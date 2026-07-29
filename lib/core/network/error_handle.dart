// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class ErrorHandle {
  static String handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.badCertificate:
        print("error: ${e.message}");
        return "Bad certificate. Please try again.";

      case DioExceptionType.badResponse:
        print("Status Code: ${e.response?.statusCode}");
        print("Response Data: ${e.response?.data}");

        if (e.response != null && e.response?.data != null) {
          final data = e.response?.data;

          if (data is Map<String, dynamic>) {
            if (data.containsKey('message') && data['message'] != null) {
              return data['message'].toString();
            } else if (data.containsKey('error') && data['error'] != null) {
              return data['error'].toString();
            } else if (data.containsKey('msg') && data['msg'] != null) {
              return data['msg'].toString();
            }
          }
          

          return "Server error: ${e.response?.statusCode}";
        }
        return "Unexpected error occurred. Please try again.";

      case DioExceptionType.cancel:
        print("error: ${e.message}");
        return "Request was cancelled.";

      case DioExceptionType.connectionError:
        print("error: ${e.message}");
        return "Connection error. Please check your internet.";

      case DioExceptionType.connectionTimeout:
        print("error: ${e.message}");
        return "Connection timeout. Please try again.";

      case DioExceptionType.receiveTimeout:
        print("error: ${e.message}");
        return "Receive timeout. Please try again.";

      case DioExceptionType.sendTimeout:
        print("error: ${e.message}");
        return "Send timeout. Please try again.";

      case DioExceptionType.unknown:
        print("error: ${e.message}");
        return "Unknown error occurred. Please try again.";
      
      default:
        return "Something went wrong.";
    }
  }
}