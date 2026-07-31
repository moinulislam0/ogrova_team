

import '../sources/remote/auth_api_service.dart';

class AuthRepository {
  final AuthApiService remoteSource;
  AuthRepository({required this.remoteSource});
    Future<bool> login({required String email ,required String password})async {
   return await remoteSource.login(email: email,password: password);
  }
}