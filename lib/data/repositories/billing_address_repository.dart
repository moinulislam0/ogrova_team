import 'package:ogrova_team/data/models/billing_address_model.dart';
import 'package:ogrova_team/data/sources/remote/billing_address_api_service.dart';

class BillingAddressRepository {
  BillingAddressModel? data;
  BillingAddressapiService remote;
  BillingAddressRepository({required this.remote, this.data});
  Future<BillingAddressModel> billingAddress() async {
    return remote.billing();
  }
}
