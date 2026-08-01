import 'dart:io';

import '../sources/remote/auth_api_service.dart';

class AuthRepository {
  final AuthApiService remoteSource;
  AuthRepository({required this.remoteSource});
  Future<bool> login({
    required String email,
    required String password,
    required bool remember,
  }) async {
    return await remoteSource.login(
      email: email,
      password: password,
      remember: remember,
    );
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String dob,
    required String gender,
    required String blood,
    required String present,
    required String permanent,
    required String pass,
    required String Cpass,
    File? photo,
  }) async {
    return await remoteSource.register(
      name: name,
      email: email,
      phone: phone,
      dob: dob,
      gender: gender,
      blood: blood,
      present: present,
      permanent: permanent,
      pass: pass,
      Cpass: Cpass,
      photo: photo,
    );
  }
}

