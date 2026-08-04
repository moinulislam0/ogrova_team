import 'package:ogrova_team/data/models/get_categories_model.dart';
import 'package:ogrova_team/data/models/get_category_products_model.dart';
import 'package:ogrova_team/data/models/searching_model.dart';
import 'package:ogrova_team/data/sources/remote/getCategories_service.dart';

class GetCategoriesRepository {
  GetCategoriesModel? pruducts;
  GetcategoriesService remoteService;
  GetCategoriesRepository({required this.remoteService, this.pruducts});

  Future<GetCategoriesModel> getData() async {
    return remoteService.getData();
  }

  Future<GetCategoriesProductsModel> getCategoryProducts(int id) async {
    return remoteService.getCategoryProducts(id);
  }

  Future<SearchModel> searchProducts(String query, int page) async {
    return remoteService.searchProducts(query, page);
  }

  Future<SearchModel> searchSuggest() async {
    return remoteService.searchSuggest();
  }
}
