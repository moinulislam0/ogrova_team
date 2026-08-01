import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/network/api_clients.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/sources/remote/auth_api_service.dart';
class SignInState {
  final bool isLoading;
  final String? errorMessage;

  SignInState({required this.isLoading, this.errorMessage});

  SignInState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return SignInState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class SignInModelview extends StateNotifier<SignInState> {
  final AuthRepository repository;
  SignInModelview({required this.repository})
    : super(SignInState(isLoading: false));
  Future<bool> signIn({
    required String email,
    required String password,
    required bool remember,
  }) async {
    state = state.copyWith(isLoading: true, clearErrorMessage: true);
    try {
      final success = await repository.login(
        email: email,
        password: password,
        remember: remember,
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
final signInViewModelProvider =
    StateNotifierProvider<SignInModelview, SignInState>(
      (ref) => SignInModelview(
        repository: AuthRepository(
          remoteSource: AuthApiService(apiClient: ApiClient()),
        ),
      ),
    );


