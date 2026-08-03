import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/data/models/get_categories_model.dart';
import 'package:ogrova_team/data/models/get_category_products_model.dart';
import 'package:ogrova_team/data/repositories/get_categories_repository.dart';
import 'package:ogrova_team/data/sources/remote/getCategories_service.dart';

class GetCategoriesState {
  final String? errorMessage;
  final bool isLoading;
  final GetCategoriesModel? data;
  final GetCategoriesProductsModel? categoryProducts;

  GetCategoriesState({
    required this.isLoading,
    this.errorMessage,
    this.data,
    this.categoryProducts,
  });

  GetCategoriesState copyWith({
    bool? isLoading,
    String? errorMessage,
    GetCategoriesModel? data,
    GetCategoriesProductsModel? categoryProducts,
  }) {
    return GetCategoriesState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      // এখানে লজিক পরিবর্তন করা হয়েছে যাতে null পাস করা যায়
      categoryProducts: categoryProducts, 
    );
  }
}

class GetCategoriesProvider extends StateNotifier<GetCategoriesState> {
  final GetCategoriesRepository remote;

  GetCategoriesProvider({required this.remote})
      : super(GetCategoriesState(isLoading: false));

  Future<bool> getPublicProducts() async {
    state = state.copyWith(isLoading: true, errorMessage: null, categoryProducts: state.categoryProducts);
    try {
      final response = await remote.getData();
      state = state.copyWith(isLoading: false, data: response, categoryProducts: state.categoryProducts);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
        categoryProducts: state.categoryProducts
      );
      return false;
    }
  }

  Future<bool> getProductsByCategory(int id) async {
    state = state.copyWith(isLoading: true, errorMessage: null, categoryProducts: null);
    try {
      final response = await remote.getCategoryProducts(id);
      state = state.copyWith(isLoading: false, categoryProducts: response);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
        categoryProducts: null,
      );
      return false;
    }
  }

  // এটিই "All" বাটনের জন্য সমাধান
  void clearCategoryProducts() {
    state = GetCategoriesState(
      isLoading: false,
      errorMessage: null,
      data: state.data, 
      categoryProducts: null, // এখানে সরাসরি null করে দেওয়া হয়েছে
    );
  }
}

final getProductsProvider =
    StateNotifierProvider<GetCategoriesProvider, GetCategoriesState>((ref) {
  return GetCategoriesProvider(
    remote: GetCategoriesRepository(
      remoteService: GetcategoriesService(apiClient: ApiClient()),
    ),
  );
});