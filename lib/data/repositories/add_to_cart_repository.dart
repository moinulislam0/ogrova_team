import 'package:ogrova_team/data/sources/remote/add_to_cart_service.dart';

class AddToCartRepository {
  final AddToCartService resource;
  AddToCartRepository({required this.resource});
  Future<bool> addToCart({
    required int productdId,
    required int vriantId,
    required int quantity,
  }) async {
    return resource.addCart(
      productId: productdId,
      variantId: vriantId,
      quantity: quantity,
    );
  }
}
