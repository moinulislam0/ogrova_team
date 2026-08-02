import 'package:flutter_riverpod/legacy.dart';
import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/data/models/billing_address_model.dart';
import 'package:ogrova_team/data/repositories/billing_address_repository.dart';
import 'package:ogrova_team/data/sources/remote/billing_address_api_service.dart';

class BillingAddressState {
  final String? errorMessage;
  final bool isLoading;
  final BillingAddressModel? data;

  BillingAddressState ({required this.isLoading, this.errorMessage, this.data});

 BillingAddressState  copyWith({
    bool? isLoading,
    String? errorMessage,
    BillingAddressModel? data,
  }) {
    return BillingAddressState (
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}

class BillingAddressProvider extends StateNotifier<BillingAddressState> {
  final BillingAddressRepository remote;

 BillingAddressProvider({required this.remote})
    : super(BillingAddressState(isLoading: false));

  Future<bool> getPublicProducts() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await remote.billingAddress();

      state = state.copyWith(
        isLoading: false,
        data: response,
        errorMessage: null,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    }
  }
}

final billingAddressProvider =
    StateNotifierProvider<BillingAddressProvider,BillingAddressState>((ref) {
      return BillingAddressProvider(
        remote:BillingAddressRepository(
          remote: BillingAddressapiService(apiClient: ApiClient()),
        ),
      );
    });
