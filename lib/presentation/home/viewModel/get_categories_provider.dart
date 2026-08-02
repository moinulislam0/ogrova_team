import 'package:flutter_riverpod/legacy.dart';
import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/data/models/get_categories_model.dart';
import 'package:ogrova_team/data/repositories/get_categories_repository.dart';
import 'package:ogrova_team/data/sources/remote/getCategories_service.dart';

class GetCategoriesState {
  final String? errorMessage;
  final bool isLoading;
  final GetCategoriesModel? data;

 GetCategoriesState({required this.isLoading, this.errorMessage, this.data});

  GetCategoriesState copyWith({
    bool? isLoading,
    String? errorMessage,
    GetCategoriesModel? data,
  }) {
    return GetCategoriesState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
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

      state = state.copyWith(
        isLoading: false,
        data: response,
        errorMessage: null,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    }
  }
}

final getProductsProvider =
    StateNotifierProvider<GetCategoriesProvider, GetCategoriesState>((ref) {
      return GetCategoriesProvider(
        remote:GetCategoriesRepository(
          remoteService: GetcategoriesService(apiClient: ApiClient()),
        ),
      );
    });
