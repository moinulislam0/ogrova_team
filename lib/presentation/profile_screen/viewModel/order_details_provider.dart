import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/data/models/oder_details_model.dart';
import 'package:ogrova_team/data/repositories/order_details_repository.dart';
import 'package:ogrova_team/data/sources/remote/order_details_service.dart';
import 'package:riverpod/legacy.dart';

class OrderDetailsState {
  final bool isloading;
  final String? errormessage;
  OrderDetailsModel? data;
  OrderDetailsState({required this.isloading, this.errormessage, this.data});
 OrderDetailsState copyWith({
    bool? isloading,
    String? errorMessage,
    OrderDetailsModel? data,
  }) {
    return OrderDetailsState(
      isloading: isloading ?? this.isloading,
      data: data ?? this.data,
      errormessage: errorMessage ?? this.errormessage,
    );
  }
}

class OrderDetailsProvider extends StateNotifier<OrderDetailsState> {
  OrderDetailsRepository remote;
  OrderDetailsProvider({required this.remote})
    : super(OrderDetailsState(isloading: false));

  Future<bool> getdata() async {
    state = state.copyWith(isloading: true, errorMessage: null);
    try {
      final response = await remote.getData();
      state = state.copyWith(
        isloading: false,
        data: response,
        errorMessage: null,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isloading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    }
  }
}

final orderDetailsProvider =
    StateNotifierProvider<OrderDetailsProvider, OrderDetailsState>((ref) {
      return OrderDetailsProvider(
        remote: OrderDetailsRepository(
          remote: OrderDetailsService(apiClient: ApiClient()),
        ),
      );
    });
