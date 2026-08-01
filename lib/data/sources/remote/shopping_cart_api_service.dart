import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/core/network/api_endpoints.dart';
import 'package:ogrova_team/data/models/shopping_cart_model.dart';

class ShoppingCartApiService {
  final ShoppingCartModel? data;
  final ApiClient apiClient;
  ShoppingCartApiService({required this.apiClient, this.data});
  Future<ShoppingCartModel> getData() async {
    try {
      final response = await apiClient.getRequest(
        endpoints: ApiEndpoints.shoppingCart,
      );
      // The cart endpoint returns {message, reg, data}; unlike some endpoints
      // it does not need a `success` field to contain valid cart data.
      if (response is Map) {
        return ShoppingCartModel.fromJson(Map<String, dynamic>.from(response));
      }
      return ShoppingCartModel();
    } catch (e) {
         rethrow;
    }
  }

  Future<bool> updateQuantity({
    required String reg,
    required int productId,
    required int variantId,
    required int quantity,
  }) async {
    final response = await apiClient.postRequest(
      endpoints: ApiEndpoints.updateCartQuantity(reg, productId, variantId),
      body: {'quantity': quantity},
    );

    // Non-2xx responses throw in ApiClient. Any returned map is a successful
    // quantity update response from the backend.
    return response is Map;
  }
}
