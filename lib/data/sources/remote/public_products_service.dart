import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/core/network/api_endpoints.dart';
import 'package:ogrova_team/data/models/public_products_model.dart';

class PublicProductsService {
  ApiClient apiClient;
  ProductResponse? productsModel;
  PublicProductsService({required this.apiClient,  this.productsModel});

  Future<ProductResponse> publicProducts() async {
    try {
      final response = await apiClient.getRequest(
        endpoints: ApiEndpoints.publicProducts,
      );
      if (response is Map<String, dynamic> && response['success'] == true) {
      
        return ProductResponse.fromJson(response);
      }
      return ProductResponse();
    } catch (e) {
         rethrow;
    }
  }
}
