import 'package:ogrova_team/data/models/get_categories_model.dart';
import 'package:ogrova_team/data/models/public_products_model.dart';
import 'package:ogrova_team/data/sources/remote/getCategories_service.dart';
import 'package:ogrova_team/data/sources/remote/public_products_service.dart';

class GetCategoriesRepository {
  GetCategoriesModel? pruducts;
  GetcategoriesService remoteService;
  GetCategoriesRepository({required this.remoteService, this.pruducts});
  Future<GetCategoriesModel> getData() async {
    return remoteService.getData();
  }
}
