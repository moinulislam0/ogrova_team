import 'package:flutter_riverpod/legacy.dart';
import 'package:ogrova_team/data/repositories/profile_update_repository.dart';
import 'package:ogrova_team/data/sources/remote/profile_upadate_service.dart';

import '../../../../core/network/api_clients.dart';

class ProfileUpdateState {
  final bool isLoading;
  final String? errorMessage;

  ProfileUpdateState({required this.isLoading, this.errorMessage});

  ProfileUpdateState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return ProfileUpdateState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
    );
  }
}

class ProfileUpdateProvider extends StateNotifier<ProfileUpdateState> {
  final ProfileUpdateRepository repository;
  ProfileUpdateProvider({required this.repository})
    : super(ProfileUpdateState(isLoading: false));
  Future<bool> profileUpdate({
    required String name,
    required String email,

    required String dob,
    required String phone,
    required String gender,
    required String bloodGroup,
    required String presentAddress,
    required String permanentAddress,
    required String nationalId,
    required String photo,
  }) async {
    state = state.copyWith(isLoading: true, clearErrorMessage: true);
    try {
      final success = await repository.profileUpdate(
        email: email,
        name: name,
        bloodGroup: bloodGroup,
        dob: dob,
        gender: gender,
        nationalId: nationalId,
        permanentAddress: permanentAddress,
        phone: phone,
        photo: photo,
        presentAddress: presentAddress,
      );
      state = state.copyWith(isLoading: false);
      return success;
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: error.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    }
  }

  void isLoading() {
    state = state.copyWith(isLoading: !state.isLoading);
  }
}

final profileUpdateProvider =
    StateNotifierProvider<ProfileUpdateProvider, ProfileUpdateState>(
      (ref) => ProfileUpdateProvider(
        repository: ProfileUpdateRepository(
          remote: ProfileUpdateService(apiclient: ApiClient()),
        ),
      ),
    );
