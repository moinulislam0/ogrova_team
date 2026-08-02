import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
  )..interceptors.add(_ApiDebugInterceptor());

  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Token set korar jonno function
  static Future<void> headerSet([String? manualToken]) async {
    final storedToken = await SharedPreferenceData.getToken();
    final token = (manualToken ?? storedToken)?.trim();

    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      // Support tokens saved by older app versions that already included the
      // scheme, while always sending exactly one Bearer prefix.
      final accessToken = token.replaceFirst(
        RegExp(r'^Bearer\s+', caseSensitive: false),
        '',
      );
      headers['Authorization'] = 'Bearer $accessToken';
    }
    
    // Dio instance er default header update korchi
    _dio.options.headers = headers;
  }

  /// GET request
  Future<dynamic> getRequest({
    required String endpoints,
  }) async {
    try {
      await headerSet();
      
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
      await headerSet();
      
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
   Future<dynamic> putRequest({
    required String endpoints,
    required dynamic body,
  }) async {
    try {
      await headerSet();
      
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
   Future<dynamic> patchRequest({
    required String endpoints,
    Map<String, dynamic>? body,
    FormData? formData,
  }) async {
    try {
      await headerSet();
      
      final response = await _dio.patch(
        '/$endpoints',
        data: body ?? formData,
        options: Options(
          headers: headers,
          contentType: formData != null ? 'multipart/form-data' : 'application/json',
        ),
      );

      return ResposeHandle.handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  /// DELETE request
  Future<dynamic> deleteRequest({
    required String endpoints,
  }) async {
    try {
      await headerSet();
      
      final response = await _dio.delete(
        '/$endpoints',
        options: Options(headers: headers),
      );

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
      return null;
    }
  }
}

/// Logs every request and response to the IDE debug console in debug builds.
/// Request headers are deliberately excluded so authentication tokens are not
/// written to the console.
class _ApiDebugInterceptor extends Interceptor {
  static const _logName = 'API';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      developer.log(
        'REQUEST ${options.method} ${options.uri}'
        '\nData: ${options.data ?? 'No request body'}',
        name: _logName,
      );
    }
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      developer.log(
        'RESPONSE ${response.statusCode} ${response.requestOptions.method} '
        '${response.requestOptions.uri}'
        '\nData: ${response.data}',
        name: _logName,
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      developer.log(
        'ERROR ${err.response?.statusCode ?? 'No status'} '
        '${err.requestOptions.method} ${err.requestOptions.uri}'
        '\nMessage: ${err.message}'
        '\nResponse data: ${err.response?.data}',
        name: _logName,
        error: err,
      );
    }
    handler.next(err);
  }
}
