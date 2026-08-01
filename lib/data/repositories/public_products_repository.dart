import 'package:ogrova_team/data/models/public_products_model.dart';
import 'package:ogrova_team/data/sources/remote/public_products_service.dart';

class PublicProductsRepository {
  ProductResponse? pruducts;
  PublicProductsService remoteService;
  PublicProductsRepository({required this.remoteService, this.pruducts});
  Future<ProductResponse> products() async {
    return remoteService.publicProducts();
  }
}
