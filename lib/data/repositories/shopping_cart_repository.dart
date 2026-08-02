import 'package:ogrova_team/data/models/shopping_cart_model.dart';
import 'package:ogrova_team/data/sources/remote/shopping_cart_api_service.dart';

class ShoppingCartRepository {
  ShoppingCartApiService resource;
  final ShoppingCartModel? data;
  ShoppingCartRepository({required this.resource, this.data});
  Future<ShoppingCartModel> getData() async {
    return resource.getData();
  }

  Future<bool> updateQuantity({
    required String reg,
    required int productId,
    required int variantId,
    required int quantity,
  }) {
    return resource.updateQuantity(
      reg: reg,
      productId: productId,
      variantId: variantId,
      quantity: quantity,
    );
  }

  Future<bool> deleteCart({
    required int cartId,
    required String reg,
    required int productId,
    required int variantId,
  }) {
    return resource.deleteCart(
      cartId: cartId,
      reg: reg,
      productId: productId,
      variantId: variantId,
    );
  }


}
