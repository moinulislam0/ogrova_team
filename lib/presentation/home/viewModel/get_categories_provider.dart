import 'package:flutter_riverpod/legacy.dart';
import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/data/models/get_categories_model.dart';
import 'package:ogrova_team/data/models/get_category_products_model.dart';
import 'package:ogrova_team/data/models/searching_model.dart';
import 'package:ogrova_team/data/repositories/get_categories_repository.dart';
import 'package:ogrova_team/data/sources/remote/getCategories_service.dart';

class GetCategoriesState {
  final String? errorMessage;
  final bool isLoading;
  final GetCategoriesModel? data;
  final GetCategoriesProductsModel? categoryProducts;
  final SearchModel? searchData; 

  GetCategoriesState({
    required this.isLoading,
    this.errorMessage,
    this.data,
    this.categoryProducts,
    this.searchData, // এখানেও যোগ করুন
  });

  GetCategoriesState copyWith({
    bool? isLoading,
    String? errorMessage,
    GetCategoriesModel? data,
    GetCategoriesProductsModel? categoryProducts,
   SearchModel? searchData, 
    bool isClearing = false,
  }) {
    return GetCategoriesState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      categoryProducts: isClearing ? null : (categoryProducts ?? this.categoryProducts),
      searchData: isClearing ? null : (searchData ?? this.searchData), // আপডেট
    );
  }
}

class GetCategoriesProvider extends StateNotifier<GetCategoriesState> {
  final GetCategoriesRepository remote;

  GetCategoriesProvider({required this.remote})
    : super(GetCategoriesState(isLoading: false));


  Future<bool> getPublicProducts() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response = await remote.getData();
      state = state.copyWith(isLoading: false, data: response);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

 Future<bool> searchProducts(String query, {int page = 1}) async {
  state = state.copyWith(isLoading: true, errorMessage: null, isClearing: true);
  try {
    final response = await remote.searchProducts(query, page);
    state = state.copyWith(
      isLoading: false, 
      searchData: response, 
      isClearing: false
    );
    return true;
  } catch (e) {
    state = state.copyWith(
      isLoading: false, 
      errorMessage: e.toString(), 
      isClearing: true
    );
    return false;
  }
}
 Future<bool> searchSuggest() async {
  state = state.copyWith(isLoading: true, errorMessage: null, isClearing: true);
  try {
    final response = await remote.searchSuggest(); 
    state = state.copyWith(
      isLoading: false, 
      searchData: response, 
      isClearing: false
    );
    return true;
  } catch (e) {
    state = state.copyWith(isLoading: false, errorMessage: e.toString(), isClearing: true);
    return false;
  }
}
  Future<bool> getProductsByCategory(int id) async {
   
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      isClearing: true,
    );
    try {
      final response = await remote.getCategoryProducts(id);
      state = state.copyWith(
        isLoading: false,
        categoryProducts: response,
        isClearing: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        isClearing: true,
      );
      return false;
    }
  }

 
  void clearCategoryProducts() {
    state = state.copyWith(
      isLoading: false,
      errorMessage: null,
      isClearing: true,
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
