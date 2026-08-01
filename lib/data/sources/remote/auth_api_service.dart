import 'dart:io';
import 'dart:developer' as developer;

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

  Future<bool> login({required String email, required String password}) async {
    try {
      final body = {"email": email, "password": password};

      final dynamic response = await apiClient.postRequest(
        body: body,
        endpoints: ApiEndpoints.login,
      );

      // Ekhane check kora hocche response ki Map naki List
      if (response != null && response is Map<String, dynamic>) {
        if (response['success'] == true) {
          String tokenType = response['token_type'] ?? 'Bearer';
          String token = response['token'] ?? "";

          await SharedPreferenceData.setToken("$tokenType $token");
          return true;
        } else {
          developer.log("Login Failed: ${response['message']}");
          return false;
        }
      }
      // Jodi backend theke List ashe (bhul vabe)
      else if (response is List && response.isNotEmpty) {
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
      rethrow;
    } catch (error) {
      developer.log("General Error: $error");
      rethrow;
    }
  }
}
