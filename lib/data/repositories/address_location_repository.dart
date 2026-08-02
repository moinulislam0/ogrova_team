import 'package:ogrova_team/data/models/address_location_model.dart';
import 'package:ogrova_team/data/sources/remote/address_location_api_service.dart';

class AddressLocationRepository {
  final AddressLocationApiService resource;

  AddressLocationRepository({required this.resource});

  Future<List<AddressLocationModel>> getDivisions() => resource.getDivisions();
  Future<List<AddressLocationModel>> getDistricts(int divisionId) =>
      resource.getDistricts(divisionId);
  Future<List<AddressLocationModel>> getUpazilas(int districtId) =>
      resource.getUpazilas(districtId);
  Future<List<AddressLocationModel>> getPoliceStations(int upazilaId) =>
      resource.getPoliceStations(upazilaId);
}
