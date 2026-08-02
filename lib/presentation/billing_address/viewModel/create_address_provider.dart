import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/data/repositories/create_address_repository.dart';
import 'package:ogrova_team/data/sources/remote/create_address_api_service.dart';
import 'package:riverpod/legacy.dart';

class CreateAddressState {
  final String? errorMessage;
  final bool isloading;
  CreateAddressState({required this.isloading, this.errorMessage});
  CreateAddressState copyWith({
    bool? isloading,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return CreateAddressState(
      isloading: isloading ?? this.isloading,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class CreateAddressProvider extends StateNotifier<CreateAddressState> {
  final CreateAddressRepository remote;
  CreateAddressProvider({required this.remote})
    : super(CreateAddressState(isloading: false));
  Future<bool> crateAddress({
    required String office,
    required String recipientName,
    required String phone,
    required int division,
    required int districtId,
    required int upazilaId,
    int? policeStationId,
    required String address,
    String? postCode,
    bool? isDefault,
  }) async {
    state = state.copyWith(isloading: true, clearErrorMessage: true);
    try {
      final response = await remote.createAddress(
        office: office,
        recipientName: recipientName,
        phone: phone,
        division: division,
        districtId: districtId,
        upazilaId: upazilaId,
        policeStationId: policeStationId,
        address: address,
        postCode: postCode,
        isDefault: isDefault,
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

final createAddressProvider =
    StateNotifierProvider<CreateAddressProvider, CreateAddressState>((ref) {
      return CreateAddressProvider(
        remote: CreateAddressRepository(
          resource: CreateAddressApiService(apiClient: ApiClient()),
        ),
      );
    });
