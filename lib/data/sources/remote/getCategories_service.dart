import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/core/network/api_endpoints.dart';
import 'package:ogrova_team/data/models/get_categories_model.dart';
import 'package:ogrova_team/data/models/get_category_products_model.dart';
import 'package:ogrova_team/data/models/public_products_model.dart'; // প্রোডাক্ট মডেল ইম্পোর্ট

class GetcategoriesService {
  final ApiClient apiClient;
  GetCategoriesModel? productDetails;
  GetcategoriesService({required this.apiClient, this.productDetails});

  // ক্যাটাগরি লিস্ট আনার মেথড
  Future<GetCategoriesModel> getData() async {
    try {
      final response = await apiClient.getRequest(
        endpoints: ApiEndpoints.getCategories,
      );

      if (response is Map<String, dynamic> && response['success'] == true) {
        return GetCategoriesModel.fromJson(response);
      }
      return GetCategoriesModel();
    } catch (e) {
      rethrow;
    }
  }

 
  Future<GetCategoriesProductsModel> getCategoryProducts(int id) async {
    try {
      final response = await apiClient.getRequest(
        endpoints: ApiEndpoints.categoryProducts(id),
      );
      if (response is Map<String, dynamic>) {
        return GetCategoriesProductsModel.fromJson(response);
      }
      return GetCategoriesProductsModel();
    } catch (e) {
      rethrow;
    }
  }
}