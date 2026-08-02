import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/core/network/api_endpoints.dart';
import 'package:ogrova_team/data/models/billing_address_model.dart';
import 'package:ogrova_team/data/models/oder_details_model.dart';

class OrderDetailsService {
  ApiClient apiClient;
  OrderDetailsModel? data;
  OrderDetailsService({required this.apiClient, this.data});

  Future< OrderDetailsModel> orderDetails() async {
    try {
      final response = await apiClient.getRequest(
        endpoints: ApiEndpoints.orderDetails,
      );
      if (response is Map<String, dynamic> && response['success'] == true) {
        return   OrderDetailsModel.fromJson(response);
      }
      return   OrderDetailsModel();
    } catch (e) {
      rethrow;
    }
  }
}
