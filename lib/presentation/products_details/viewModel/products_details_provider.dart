import 'package:image_picker/image_picker.dart';
import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/data/models/products_details_model.dart';
import 'package:ogrova_team/data/repositories/products_details_repository.dart';
import 'package:ogrova_team/data/sources/remote/products_details_api_service.dart';
import 'package:riverpod/legacy.dart';

class ProductsDetailsState {
  final bool isloading;
  final String? errormessage;
  ProductDetails? data;
  ProductsDetailsState({required this.isloading, this.errormessage, this.data});
  ProductsDetailsState copyWith({
    bool? isloading,
    String? errorMessage,
    ProductDetails? data,
  }) {
    return ProductsDetailsState(
      isloading: isloading ?? this.isloading,
      data: data ?? this.data,
      errormessage: errorMessage ?? this.errormessage,
    );
  }
}

class ProductsDetailsProvider extends StateNotifier<ProductsDetailsState> {
  ProductsDetailsRepository remote;
  ProductsDetailsProvider({required this.remote})
    : super(ProductsDetailsState(isloading: false));
  Future<bool> getdata(String slug) async {
    state = state.copyWith(isloading: true, errorMessage: null);
    try {
      final response = await remote.getData(slug);
      state = state.copyWith(
        isloading: false,
        data: response,
        errorMessage: null,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isloading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    }
  }
}

final productDetailsProvider =
    StateNotifierProvider<ProductsDetailsProvider, ProductsDetailsState>((ref) {
      return ProductsDetailsProvider(
        remote: ProductsDetailsRepository(
          remote: ProductsDetailsApiService(apiClient: ApiClient()),
        ),
      );
    });
