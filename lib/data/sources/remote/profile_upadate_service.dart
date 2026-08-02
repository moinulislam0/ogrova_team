import 'package:dio/dio.dart';
import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/core/network/api_endpoints.dart';

class ProfileUpdateService {
  final ApiClient apiclient;
  ProfileUpdateService({required this.apiclient});

  Future<bool> profileUpdate({
    required String name,
    required String email,
    required String dob,
    required String phone,
    required String gender,
    required String bloodGroup,
    required String presentAddress,
    required String permanentAddress,
    required String nationalId,
    required String photo, 
  }) async {
    try {

      Map<String, dynamic> body = {
        "name": name,
        "email": email,
        "phone": phone,
        "dob": dob,
        "gender": gender.toLowerCase(), 
        "blood_group": bloodGroup,
        "present_address": presentAddress,
        "permanent_address": permanentAddress,
        "national_id": nationalId,
      };

     
      if (photo.isNotEmpty && !photo.startsWith('http')) {
        body["photo"] = await MultipartFile.fromFile(
          photo,
          filename: photo.split('/').last,
        );
      }

     
      FormData formData = FormData.fromMap(body);

      
      final response = await apiclient.putRequest(
        endpoints: ApiEndpoints.profile,
        body: formData, 
      );

      if (response != null) {
        return true;
      }
      return false;
    } on DioException catch (e) {
      
      String errorMessage = "Validation Error";
      if (e.response?.data['errors'] != null) {
        var errors = e.response?.data['errors'] as Map;
      
        errorMessage = errors.values.first[0].toString();
      } else {
        errorMessage = e.response?.data['message'] ?? "Update failed";
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception("An unexpected error occurred");
    }
  }
}