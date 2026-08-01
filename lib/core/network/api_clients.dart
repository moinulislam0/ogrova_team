import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ogrova_team/data/sources/local/shared_preference/shared_prefenrence.dart';

import 'api_endpoints.dart';
import 'error_handle.dart';
import 'response_handle.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      // Default headers shob request er jonno
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Token set korar jonno function
  static Future<void> headerSet([String? manualToken]) async {
    final storedToken = await SharedPreferenceData.getToken();
    String? token = manualToken ?? storedToken;

    log("Token initialized: ${token ?? 'No Token Found'}");

    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    
    // Dio instance er default header update korchi
    _dio.options.headers = headers;
  }

  /// GET request
  Future<dynamic> getRequest({
    required String endpoints,
  }) async {
    try {
      log("\nURL: ${ApiEndpoints.baseUrl}/$endpoints");
      
      final response = await _dio.get(
        '/$endpoints',
        options: Options(headers: headers),
      );
      
      return ResposeHandle.handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  /// POST request
  Future<dynamic> postRequest({
    required String endpoints,
    Map<String, dynamic>? body,
    FormData? formData,
  }) async {
    try {
      log("\nURL: ${ApiEndpoints.baseUrl}/$endpoints");
      
      final response = await _dio.post(
        '/$endpoints',
        data: body ?? formData,
        options: Options(
          // FormData needs Dio to generate the multipart boundary itself.
          headers: formData != null
              ? (Map<String, String>.from(headers)..remove('Content-Type'))
              : headers,
        ),
      );
      
      return ResposeHandle.handleResponse(response);
    } on DioException {
      rethrow;
    } catch (e) {
      return _handleError(e);
    }
  }

  /// PUT request
  static Future<dynamic> putRequest({
    required String endpoints,
    required Map<String, dynamic> body,
  }) async {
    try {
      log("\nURL: ${ApiEndpoints.baseUrl}/$endpoints");
      
      final response = await _dio.put(
        '/$endpoints',
        data: body,
        options: Options(headers: headers),
      );
      
      return ResposeHandle.handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  /// PATCH request
  static Future<dynamic> patchRequest({
    required String endpoints,
    Map<String, dynamic>? body,
    FormData? formData,
  }) async {
    try {
      log("\nURL: ${ApiEndpoints.baseUrl}/$endpoints");
      
      final response = await _dio.patch(
        '/$endpoints',
        data: body ?? formData,
        options: Options(
          headers: headers,
          contentType: formData != null ? 'multipart/form-data' : 'application/json',
        ),
      );

      debugPrint("PATCH Request Successful: ${response.statusCode}");
      return ResposeHandle.handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  /// DELETE request
  static Future<dynamic> deleteRequest({
    required String endpoints,
  }) async {
    try {
      log("\nURL: ${ApiEndpoints.baseUrl}/$endpoints");
      
      final response = await _dio.delete(
        '/$endpoints',
        options: Options(headers: headers),
      );

      debugPrint("DELETE Request Successful: ${response.statusCode}");
      return ResposeHandle.handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  /// Common Error Handler
  static dynamic _handleError(dynamic e) {
    if (e is DioException) {
      return ErrorHandle.handleDioError(e);
    } else {
      log('Non-Dio error: $e');
      return null;
    }
  }
}
