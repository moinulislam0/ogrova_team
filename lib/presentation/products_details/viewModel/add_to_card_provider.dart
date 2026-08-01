import 'package:flutter_riverpod/legacy.dart';
import 'package:ogrova_team/data/repositories/add_to_cart_repository.dart';
import 'package:ogrova_team/data/sources/remote/add_to_cart_service.dart';
import '../../../../core/network/api_clients.dart';
class AddToCartState {
  final bool isLoading;
  final String? errorMessage;

 AddToCartState({required this.isLoading, this.errorMessage});

  AddToCartState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return AddToCartState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class AddToCardProvider extends StateNotifier<AddToCartState> {
  final AddToCartRepository repository;
  AddToCardProvider({required this.repository})
    : super(AddToCartState(isLoading: false));
  Future<bool> addToCart({
    required int productId,
    required int variantId,
    required int quantity,
  }) async {
    state = state.copyWith(isLoading: true, clearErrorMessage: true);
    try {
      final success = await repository.addToCart(
       quantity: quantity,
       productdId: productId,
       vriantId: variantId
      );
      state = state.copyWith(isLoading: false);
      return success;
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: error.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    }
  }

  void isLoading() {
    state = state.copyWith(isLoading: !state.isLoading);
  }
}
final addToCardProvider =
    StateNotifierProvider<AddToCardProvider, AddToCartState>(
      (ref) => AddToCardProvider(
        repository: AddToCartRepository(
          resource: AddToCartService(apiClient: ApiClient()),
        ),
      ),
    );


