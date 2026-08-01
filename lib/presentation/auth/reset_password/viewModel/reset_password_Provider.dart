import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/data/repositories/auth_repository.dart';
import 'package:ogrova_team/data/sources/remote/auth_api_service.dart';
import 'package:riverpod/legacy.dart';

class ResetPassState {
  final String? errorMessage;
  final bool isloading;
ResetPassState({required this.isloading, this.errorMessage});
   ResetPassState copyWith({bool? isloading, String? errorMessage}) {
    return  ResetPassState(
      isloading: isloading ?? this.isloading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class  ResetPassProvider extends StateNotifier< ResetPassState> {
  AuthRepository authRepository;
 ResetPassProvider({required this.authRepository})
    : super(ResetPassState(isloading: false));
  Future<bool> resetPass({required String email,required String pass,required String cPass}) async {
    state = state.copyWith(isloading: true, errorMessage: null);
    try {
      final success = await authRepository.resentPass(email: email,pass: pass,cPass: cPass);
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

final resetPassProvider =
    StateNotifierProvider<ResetPassProvider,ResetPassState>((ref) {
      return ResetPassProvider(
        authRepository: AuthRepository(
          remoteSource: AuthApiService(apiClient: ApiClient()),
        ),
      );
    });
