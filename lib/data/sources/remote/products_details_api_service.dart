import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/core/network/api_endpoints.dart';
import 'package:ogrova_team/data/models/products_details_model.dart';

class ProductsDetailsApiService {
  final ApiClient apiClient;
  ProductDetails? productDetails;
  ProductsDetailsApiService({required this.apiClient, this.productDetails});
  Future<ProductDetails> getData(String slug) async {
    try {
      final response = await apiClient.getRequest(
        endpoints: ApiEndpoints.productsDetails(slug),
      );
     if (response is Map<String, dynamic> && response['success'] == true) {
      
        return ProductDetails.fromJson(response);
      }
      return ProductDetails();
    } catch (e) {
         rethrow;
    }
  }
}
