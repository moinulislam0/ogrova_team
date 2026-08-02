import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/data/models/address_location_model.dart';
import 'package:ogrova_team/data/repositories/address_location_repository.dart';
import 'package:ogrova_team/data/sources/remote/address_location_api_service.dart';

class AddressLocationState {
  final bool isLoading;
  final String? errorMessage;
  final List<AddressLocationModel> divisions;
  final List<AddressLocationModel> districts;
  final List<AddressLocationModel> upazilas;
  final List<AddressLocationModel> policeStations;

  const AddressLocationState({
    this.isLoading = false,
    this.errorMessage,
    this.divisions = const [],
    this.districts = const [],
    this.upazilas = const [],
    this.policeStations = const [],
  });

  AddressLocationState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool clearErrorMessage = false,
    List<AddressLocationModel>? divisions,
    List<AddressLocationModel>? districts,
    List<AddressLocationModel>? upazilas,
    List<AddressLocationModel>? policeStations,
  }) {
    return AddressLocationState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      divisions: divisions ?? this.divisions,
      districts: districts ?? this.districts,
      upazilas: upazilas ?? this.upazilas,
      policeStations: policeStations ?? this.policeStations,
    );
  }
}

class AddressLocationProvider extends StateNotifier<AddressLocationState> {
  final AddressLocationRepository repository;

  AddressLocationProvider({required this.repository})
      : super(const AddressLocationState());

  Future<void> loadLocations() async {
    state = state.copyWith(isLoading: true, clearErrorMessage: true);
    try {
      final divisions = await repository.getDivisions();
      state = state.copyWith(isLoading: false, divisions: divisions);
    } catch (error) {
      state = state.copyWith(isLoading: false, errorMessage: error.toString());
    }
  }

  Future<void> loadDistricts(int divisionId) async {
    state = state.copyWith(
      isLoading: true,
      clearErrorMessage: true,
      districts: const [],
      upazilas: const [],
      policeStations: const [],
    );
    try {
      final districts = await repository.getDistricts(divisionId);
      state = state.copyWith(isLoading: false, districts: districts);
    } catch (error) {
      state = state.copyWith(isLoading: false, errorMessage: error.toString());
    }
  }

  Future<void> loadUpazilas(int districtId) async {
    state = state.copyWith(
      isLoading: true,
      clearErrorMessage: true,
      upazilas: const [],
      policeStations: const [],
    );
    try {
      final upazilas = await repository.getUpazilas(districtId);
      state = state.copyWith(isLoading: false, upazilas: upazilas);
    } catch (error) {
      state = state.copyWith(isLoading: false, errorMessage: error.toString());
    }
  }

  Future<void> loadPoliceStations(int upazilaId) async {
    state = state.copyWith(
      isLoading: true,
      clearErrorMessage: true,
      policeStations: const [],
    );
    try {
      final policeStations = await repository.getPoliceStations(upazilaId);
      state = state.copyWith(isLoading: false, policeStations: policeStations);
    } catch (error) {
      state = state.copyWith(isLoading: false, errorMessage: error.toString());
    }
  }
}

final addressLocationProvider =
    StateNotifierProvider<AddressLocationProvider, AddressLocationState>((ref) {
  return AddressLocationProvider(
    repository: AddressLocationRepository(
      resource: AddressLocationApiService(apiClient: ApiClient()),
    ),
  );
});
