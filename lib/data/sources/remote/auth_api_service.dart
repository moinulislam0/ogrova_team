import 'dart:developer' as developer;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/core/network/api_endpoints.dart';
import 'package:ogrova_team/data/sources/local/shared_preference/shared_prefenrence.dart';

class AuthApiService {
  final ApiClient apiClient;
  AuthApiService({required this.apiClient});
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
    try {
      final fields = <String, dynamic>{
        "name": name,
        "phone": phone,
        "dob": dob,
        "email": email,
        "gender": gender,
        "blood_group": blood,
        "present_address": present,
        "permanent_address": permanent,
        "password": pass,
        "password_confirmation": Cpass,
      };
      final formData = FormData.fromMap(fields);
      if (photo != null) {
        formData.files.add(
          MapEntry(
            'photo',
            await MultipartFile.fromFile(
              photo.path,
              filename: photo.uri.pathSegments.last,
            ),
          ),
        );
      }
      final response = await apiClient.postRequest(
        endpoints: ApiEndpoints.register,
        formData: formData,
      );
      if (response != null && response is Map && response['success'] == true) {
        return true;
      }

      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
    required bool remember,
  }) async {
    try {
      final body = {"email": email, "password": password, "remember": remember};

      final dynamic response = await apiClient.postRequest(
        body: body,
        endpoints: ApiEndpoints.login,
      );

      if (response != null && response is Map<String, dynamic>) {
        if (response['success'] == true) {
          final token = response['token']?.toString().trim() ?? "";
          if (token.isEmpty) {
            throw Exception('Login succeeded but no access token was returned.');
          }

          // Store only the token value. ApiClient owns Authorization formatting.
          await SharedPreferenceData.setToken(token);
          await ApiClient.headerSet(token);
          return true;
        } else {
          developer.log("Login Failed: ${response['message']}");
          throw Exception(response['message'] ?? 'Unable to sign in.');
        }
      } else if (response is List && response.isNotEmpty) {
        developer.log("Warning: API returned a List instead of a Map");
        final data = response[0]; // Prothom element nite hobe
        if (data['success'] == true) {
          // ... baki logic
          return true;
        }
      }

      return false;
    } on DioException catch (e) {
      developer.log("Dio Error: ${e.response?.data}");
      final responseData = e.response?.data;
      final message = responseData is Map && responseData['message'] != null
          ? responseData['message'].toString()
          : 'Unable to sign in. Please try again.';
      throw Exception(message);
    } catch (error) {
      developer.log("General Error: $error");
      rethrow;
    }
  }

  Future<bool> findAccount({required String email}) async {
    try {
      final body = {"email": email};
      final response = await apiClient.postRequest(
        endpoints: ApiEndpoints.findAccount,
        body: body,
      );

      if (response is Map &&
          (response['success'] == true || response['user'] is Map)) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> resetOtp({required String email, required String otp}) async {
    try {
      final body = {"email": email, 'otp': otp};
      final response = await apiClient.postRequest(
        endpoints: ApiEndpoints.resetOtp,
        body: body,
      );
      if (response is Map &&
          (response['success'] == true || response['user'] is Map)) {
        return true;
      }
      return false;
    } on DioException catch (e) {
      throw Exception(
        _friendlyDioMessage(
          e,
          fallback: 'The verification code is invalid or has expired.',
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> resetPass({
    required String email,
    required String pass,
    required String cPass,
  }) async {
    try {
      final body = {
        "email": email,
        'password': pass,
        "password_confirmation": cPass,
      };
      final response = await apiClient.postRequest(
        endpoints: ApiEndpoints.resetPass,
        body: body,
      );
      // This endpoint returns a success message instead of `success: true`.
      final message = response is Map ? response['message']?.toString() : null;
      if (response is Map &&
          (response['success'] == true ||
              (message?.toLowerCase().contains('password reset successful') ??
                  false))) {
        return true;
      }
      return false;
    } on DioException catch (e) {
      throw Exception(
        _friendlyDioMessage(
          e,
          fallback: 'Unable to reset your password. Please try again.',
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  String _friendlyDioMessage(DioException error, {required String fallback}) {
    final data = error.response?.data;
    if (data is Map) {
      if (data['message'] != null) return data['message'].toString();

      final errors = data['errors'];
      if (errors is Map) {
        for (final value in errors.values) {
          if (value is List && value.isNotEmpty) return value.first.toString();
          if (value != null) return value.toString();
        }
      }
    }
    return fallback;
  }
}
