import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/data/repositories/auth_repository.dart';
import 'package:ogrova_team/data/sources/remote/auth_api_service.dart';
import 'package:riverpod/legacy.dart';

class RegisterState {
  final String? errorMessage;
  final bool isloading;

  RegisterState({required this.isloading, this.errorMessage});

  RegisterState copyWith({
    bool? isloading,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return RegisterState(
      isloading: isloading ?? this.isloading,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class RegistrationProvider extends StateNotifier<RegisterState> {
  final AuthRepository authRepository;

  RegistrationProvider({required this.authRepository})
      : super(RegisterState(isloading: false));

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
    state = state.copyWith(isloading: true, clearErrorMessage: true);
    try {
      final response = await authRepository.register(
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
      state = state.copyWith(isloading: false, clearErrorMessage: true);
      return response;
    } catch (e) {
      String errorMsg = "Registration failed. Please try again.";

      if (e is DioException) {
        final dynamic resData = e.response?.data;
        if (resData is Map) {
         
          if (resData['errors'] != null && resData['errors'] is Map) {
            errorMsg = _friendlyValidationMessage(resData['errors'] as Map);
          } 
       
          else if (resData['message'] != null) {
            errorMsg = resData['message'].toString();
          }
        }
      } else {
        errorMsg = e.toString().replaceAll("Exception: ", "");
      }

      state = state.copyWith(isloading: false, errorMessage: errorMsg);
      return false;
    }
  }

  String _friendlyValidationMessage(Map errors) {
    final messages = <String>[];

    errors.forEach((field, value) {
      final fieldMessages = value is List ? value : [value];
      for (final item in fieldMessages) {
        final message = _friendlyMessage(field.toString(), item.toString());
        if (!messages.contains(message)) messages.add(message);
      }
    });

    if (messages.isEmpty) return 'Please review your details and try again.';

    return 'Please fix the following:\n${messages.map((item) => '- $item').join('\n')}';
  }

  String _friendlyMessage(String field, String message) {
    final normalized = message.toLowerCase();

    if (field == 'dob' && normalized.contains('valid date')) {
      return 'Enter your date of birth in a valid date format.';
    }
    if (field == 'password') {
      if (normalized.contains('at least 8 characters')) {
        return 'Password must be at least 8 characters long.';
      }
      if (normalized.contains('uppercase') && normalized.contains('lowercase')) {
        return 'Password needs both an uppercase and a lowercase letter.';
      }
      if (normalized.contains('symbol')) {
        return 'Password needs at least one symbol, such as @, #, or !.';
      }
      if (normalized.contains('at least one letter')) {
        return 'Password needs at least one letter.';
      }
    }

    final fieldName = _fieldName(field);
    return message.replaceFirst(
      RegExp('^The ${RegExp.escape(field)} field ', caseSensitive: false),
      '$fieldName ',
    );
  }

  String _fieldName(String field) {
    const names = {
      'name': 'Name',
      'email': 'Email',
      'phone': 'Phone number',
      'dob': 'Date of birth',
      'gender': 'Gender',
      'blood': 'Blood group',
      'present': 'Present address',
      'permanent': 'Permanent address',
      'password': 'Password',
    };
    return names[field] ?? field;
  }
}

final registerProviderId =
    StateNotifierProvider<RegistrationProvider, RegisterState>((ref) {
  return RegistrationProvider(
    authRepository: AuthRepository(
      remoteSource: AuthApiService(apiClient: ApiClient()),
    ),
  );
});

