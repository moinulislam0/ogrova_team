import 'package:ogrova_team/data/sources/remote/add_to_cart_service.dart';
import 'package:ogrova_team/data/sources/remote/create_address_api_service.dart';

class CreateAddressRepository {
  final CreateAddressApiService resource;
  CreateAddressRepository({required this.resource});
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
    return resource.createAddress(
      office: office,
      recipientName: recipientName,
      phone: phone,
      division: division,
      districtId: districtId,
      upazilaId: upazilaId,
      policeStationId: policeStationId,
      address: address,
      postCode: postCode,
      isDefault: isDefault,
    );
  }
}
