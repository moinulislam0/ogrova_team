import 'package:dio/dio.dart';
import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/core/network/api_endpoints.dart';

class AddToCartService {
  final ApiClient apiClient;
  AddToCartService({required this.apiClient});

  Future<bool> addCart({
    required int productId,
    required int variantId,
    required int quantity,
  }) async {
    try {
      final body = {
        "product_id": productId,
        'variant_id': variantId,
        "quantity": quantity,
      };

      final response = await apiClient.postRequest(
        endpoints: ApiEndpoints.addToCart,
        body: body,
      );

    
      if (response != null && response['success'] == true) {
        return true;
      }
      return false;
    } on DioException catch (e) {
      String errorMessage = e.response?.data['message'] ?? "Failed to add to cart";
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception("An unexpected error occurred");
    }
  }
}