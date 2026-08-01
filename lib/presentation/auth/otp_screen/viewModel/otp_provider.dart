import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/data/repositories/auth_repository.dart';
import 'package:ogrova_team/data/sources/remote/auth_api_service.dart';
import 'package:riverpod/legacy.dart';

class OtpState {
  final String? errorMessage;
  final bool isloading;
  OtpState({required this.isloading, this.errorMessage});
   OtpState copyWith({bool? isloading, String? errorMessage}) {
    return  OtpState(
      isloading: isloading ?? this.isloading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class  OtpProvider extends StateNotifier< OtpState> {
  AuthRepository authRepository;
  OtpProvider({required this.authRepository})
    : super(OtpState(isloading: false));
  Future<bool> otp({required String email,required String otp}) async {
    state = state.copyWith(isloading: true, errorMessage: null);
    try {
      final success = await authRepository.resentOtp(email: email,otp: otp);
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

final otpStateProvider =
    StateNotifierProvider<OtpProvider, OtpState>((ref) {
      return OtpProvider(
        authRepository: AuthRepository(
          remoteSource: AuthApiService(apiClient: ApiClient()),
        ),
      );
    });
