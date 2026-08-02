import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/core/network/api_endpoints.dart';
import 'package:ogrova_team/data/models/address_location_model.dart';

class AddressLocationApiService {
  final ApiClient apiClient;

  AddressLocationApiService({required this.apiClient});

  Future<List<AddressLocationModel>> getDivisions() =>
      _getLocations(ApiEndpoints.divisions);
  Future<List<AddressLocationModel>> getDistricts(int divisionId) =>
      _getLocations('${ApiEndpoints.districts}?division_id=$divisionId');
  Future<List<AddressLocationModel>> getUpazilas(int districtId) =>
      _getLocations('${ApiEndpoints.upazilas}?district_id=$districtId');
  Future<List<AddressLocationModel>> getPoliceStations(int upazilaId) =>
      _getLocations('${ApiEndpoints.policeStations}?upazila_id=$upazilaId');

  Future<List<AddressLocationModel>> _getLocations(String endpoint) async {
    final response = await apiClient.getRequest(endpoints: endpoint);
    final items = _extractList(response);
    return items
        .whereType<Map>()
        .map((item) => AddressLocationModel.fromJson(
              Map<String, dynamic>.from(item),
            ))
        .where((item) => item.id != 0 && item.name.isNotEmpty)
        .toList();
  }

  List<dynamic> _extractList(dynamic response) {
    if (response is List) return response;
    if (response is! Map) return const [];
    if (response['data'] is List) return response['data'] as List<dynamic>;
    for (final value in response.values) {
      if (value is List) return value;
    }
    return const [];
  }
}
