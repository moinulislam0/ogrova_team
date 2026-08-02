import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/core/network/api_endpoints.dart';
import 'package:ogrova_team/data/models/get_categories_model.dart';

class GetcategoriesService {
  final ApiClient apiClient;
  GetCategoriesModel? productDetails;
  GetcategoriesService({required this.apiClient, this.productDetails});
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
  Future<bool>
}
