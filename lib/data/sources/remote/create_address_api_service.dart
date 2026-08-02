import 'package:dio/dio.dart';
import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/core/network/api_endpoints.dart';

class CreateAddressApiService {
  final ApiClient apiClient;
  CreateAddressApiService({required this.apiClient});
  Future<bool> createAddress({
    required String office,
    required String recipientName,
    required String phone,
    required int division,
    required int districtId,
    required int upazilaId,
    int? policeStationId,
    required String address,
    String? postCode,
    bool? isDefault,
  }) async {
    try {
      final body = <String, dynamic>{
        "label": office,
        "recipient_name": recipientName,
        "phone": phone,
        "division_id": division,
        "district_id": districtId,
        "upazila_id": upazilaId,
        "address": address,
        "is_default": isDefault ?? false,
      };
      if (policeStationId != null) {
        body['police_station_id'] = policeStationId;
      }
      if (postCode != null && postCode.trim().isNotEmpty) {
        body['postal_code'] = postCode.trim();
      }
      final response = await apiClient.postRequest(
        endpoints: ApiEndpoints.addressCreate,
        body: body,
      );

      if (response is Map && response['success'] == true) {
        return true;
      }
      throw Exception(response is Map
          ? response['message']?.toString() ?? 'Failed to create address.'
          : 'Failed to create address.');
    } on DioException catch (e) {
      final data = e.response?.data;
      final errors = data is Map ? data['errors'] : null;
      final validationErrors = errors is Map
          ? errors.values
              .expand((value) => value is List ? value : [value])
              .map((value) => value.toString())
              .join('\n')
          : null;
      final errorMessage = validationErrors?.isNotEmpty == true
          ? validationErrors!
          : data is Map && data['message'] != null
          ? data['message'].toString()
          : 'Failed to create address.';
      throw Exception(errorMessage);
    } catch (e) {
      rethrow;
    }
  }
}
