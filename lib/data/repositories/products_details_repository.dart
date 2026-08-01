import 'package:ogrova_team/data/models/products_details_model.dart';
import 'package:ogrova_team/data/sources/remote/products_details_api_service.dart';

class ProductsDetailsRepository {
   ProductDetails? data;
   ProductsDetailsApiService remote;
  ProductsDetailsRepository({required this.remote, this.data});
  Future<ProductDetails> getData(String slug) async {
    return remote.getData(slug);
  }
}
