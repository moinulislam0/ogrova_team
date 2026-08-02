import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/core/network/api_endpoints.dart';
import 'package:ogrova_team/data/models/billing_address_model.dart';

class BillingAddressapiService {
  ApiClient apiClient;
BillingAddressModel? data;
 BillingAddressapiService({required this.apiClient,  this.data});

  Future<BillingAddressModel> billing() async {
    try {
      final response = await apiClient.getRequest(
        endpoints: ApiEndpoints.billingAddress,
      );
      if (response is Map<String, dynamic> && response['success'] == true) {
      
        return BillingAddressModel.fromJson(response);
      }
      return BillingAddressModel();
    } catch (e) {
         rethrow;
    }
  }
}
