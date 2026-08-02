import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/data/repositories/payment_method_repository.dart';
import 'package:ogrova_team/data/sources/remote/payment_api_service.dart';
import 'package:riverpod/legacy.dart';

class PaymentMethodState {
  final String? errorMessage;
  final bool isloading;
  PaymentMethodState({required this.isloading, this.errorMessage});
 PaymentMethodState copyWith({
    bool? isloading,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return PaymentMethodState(
      isloading: isloading ?? this.isloading,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class PaymentMethodProvider extends StateNotifier<PaymentMethodState> {
  final PaymentMethodRepository remote;
  PaymentMethodProvider({required this.remote})
    : super(PaymentMethodState(isloading: false));
  Future<bool> crateAddress({
    required bool sameAdress,
    required bool sameInfo,
   
    required int addressId,
    required String paytmentMethod,
    required String remark,
    required String coupon,
    required String reg
  }) async {
    state = state.copyWith(isloading: true, clearErrorMessage: true);
    try {
      final response = await remote.paymentMethod(
       addressId: addressId,
       coupon: coupon,
       paytmentMethod: paytmentMethod,
       reg: reg,
       remark: remark,
       sameAdress: sameAdress,
       sameInfo: sameInfo,
      );
      state = state.copyWith(isloading: false);
      return response;
    } catch (error) {
      state = state.copyWith(
        isloading: false,
        errorMessage: error.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    }
  }
}

final paymentMethodProvider =
    StateNotifierProvider<PaymentMethodProvider, PaymentMethodState>((ref) {
      return PaymentMethodProvider(
        remote: PaymentMethodRepository(
          resource: PaymentApiService(apiClient: ApiClient()),
        ),
      );
    });
