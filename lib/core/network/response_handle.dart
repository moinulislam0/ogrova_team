import 'package:dio/dio.dart';
class ResposeHandle {

   static dynamic handleResponse(Response response) {
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception("Error: ${response.statusCode}, ${response.data}");
      }
    } catch (e) {
      throw Exception("Failed to parse response: $e");
    }
  }
}
