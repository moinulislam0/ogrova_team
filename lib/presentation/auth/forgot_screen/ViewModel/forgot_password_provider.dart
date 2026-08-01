import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/data/repositories/auth_repository.dart';
import 'package:ogrova_team/data/sources/remote/auth_api_service.dart';
import 'package:riverpod/legacy.dart';

class ForgotProviderState {
  final String? errorMessage;
  final bool isloading;
  ForgotProviderState({required this.isloading, this.errorMessage});
  ForgotProviderState copyWith({bool? isloading, String? errorMessage}) {
    return ForgotProviderState(
      isloading: isloading ?? this.isloading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ForgotPasswordProvider extends StateNotifier<ForgotProviderState> {
  AuthRepository authRepository;
  ForgotPasswordProvider({required this.authRepository})
    : super(ForgotProviderState(isloading: false));
  Future<bool> findAccount({required String email}) async {
    state = state.copyWith(isloading: true, errorMessage: null);
    try {
      final success = await authRepository.findAccount(email: email);
      state = state.copyWith(isloading: false);
      return success;
    } catch (error) {
      state = state.copyWith(
        isloading: false,
        errorMessage: error.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    }
  }
}

final forgotpasswordProvider =
    StateNotifierProvider<ForgotPasswordProvider, ForgotProviderState>((ref) {
      return ForgotPasswordProvider(
        authRepository: AuthRepository(
          remoteSource: AuthApiService(apiClient: ApiClient()),
        ),
      );
    });
