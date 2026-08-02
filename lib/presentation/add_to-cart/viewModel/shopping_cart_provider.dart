import 'package:flutter_riverpod/legacy.dart';
import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/data/models/shopping_cart_model.dart';
import 'package:ogrova_team/data/repositories/shopping_cart_repository.dart';
import 'package:ogrova_team/data/sources/remote/shopping_cart_api_service.dart';

class ShoppingCartState {
  final String? errorMessage;
  final bool isLoading;
  final bool isCheckingOut;
  
  final Set<String> updatingItemKeys;
  final ShoppingCartModel? data;

  ShoppingCartState({
    required this.isLoading,
    this.isCheckingOut = false,
    this.updatingItemKeys = const {},
    this.errorMessage,
    this.data,
  });

 ShoppingCartState copyWith({
    bool? isLoading,
    bool? isCheckingOut,
    Set<String>? updatingItemKeys,
    String? errorMessage,
    bool clearErrorMessage = false,
   ShoppingCartModel? data,
  }) {
    return ShoppingCartState(
      isLoading: isLoading ?? this.isLoading,
      isCheckingOut: isCheckingOut ?? this.isCheckingOut,
      updatingItemKeys: updatingItemKeys ?? this.updatingItemKeys,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      data: data ?? this.data,
    );
  }
}

class ShoppingCartProvider extends StateNotifier<ShoppingCartState> {
  final ShoppingCartRepository remote;

  ShoppingCartProvider({required this.remote})
    : super(ShoppingCartState(isLoading: false));

  Future<bool> getCartData({bool showLoading = true}) async {
    state = state.copyWith(
      isLoading: showLoading ? true : state.isLoading,
      clearErrorMessage: true,
    );

    try {
      final response = await remote.getData();

      state = state.copyWith(
        isLoading: false,
        data: response,
        clearErrorMessage: true,
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

  Future<bool> updateQuantity({
    required CartData item,
    required int quantity,
  }) async {
    final reg = item.reg;
    final productId = item.productId;
    final variantId = item.variantId;
    if (quantity < 1 || reg == null || productId == null || variantId == null) {
      state = state.copyWith(errorMessage: 'Unable to update this cart item.');
      return false;
    }

    final itemKey = _itemKey(item);
    final previousQuantity = item.quantity ?? 1;

    // Never mutate the CartData object in place. Build a new cart snapshot
    // containing a changed quantity for this row only.
    state = state.copyWith(
      data: _cartWithQuantity(itemKey, quantity),
      updatingItemKeys: {...state.updatingItemKeys, itemKey},
      clearErrorMessage: true,
    );

    try {
      final updated = await remote.updateQuantity(
        reg: reg,
        productId: productId,
        variantId: variantId,
        quantity: quantity,
      );
      if (!updated) throw Exception('Quantity update failed.');

      state = state.copyWith(
        updatingItemKeys: {...state.updatingItemKeys}..remove(itemKey),
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        // Restore only this row if the API rejects the change. This preserves
        // any successful quantity changes made to other cart rows meanwhile.
        data: _cartWithQuantity(itemKey, previousQuantity),
        updatingItemKeys: {...state.updatingItemKeys}..remove(itemKey),
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    }
  }

  Future<bool> deleteItem(CartData item) async {
    final cartId = item.id;
    final reg = item.reg;
    final productId = item.productId;
    final variantId = item.variantId;
    if (cartId == null || reg == null || productId == null || variantId == null) {
      state = state.copyWith(errorMessage: 'Unable to remove this cart item.');
      return false;
    }

    final itemKey = _itemKey(item);
    final previousData = state.data;
    state = state.copyWith(
      data: _cartWithout(itemKey),
      updatingItemKeys: {...state.updatingItemKeys, itemKey},
      clearErrorMessage: true,
    );

    try {
      final deleted = await remote.deleteCart(
        cartId: cartId,
        reg: reg,
        productId: productId,
        variantId: variantId,
      );
      if (!deleted) throw Exception('Could not remove this cart item.');

      state = state.copyWith(
        updatingItemKeys: {...state.updatingItemKeys}..remove(itemKey),
      );
      return true;
    }
     catch (e) {
      state = state.copyWith(
        data: previousData,
        updatingItemKeys: {...state.updatingItemKeys}..remove(itemKey),
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    }
  }

  String itemKey(CartData item) => _itemKey(item);

  String _itemKey(CartData item) =>
      item.id != null
          ? 'cart-${item.id}'
          : 'product-${item.productId}-variant-${item.variantId}';

  ShoppingCartModel? _cartWithQuantity(String itemKey, int quantity) {
    final cart = state.data;
    if (cart == null) return null;

    final copied = ShoppingCartModel.fromJson(cart.toJson());
    for (final cartItem in copied.data ?? <CartData>[]) {
      if (_itemKey(cartItem) == itemKey) {
        cartItem.quantity = quantity;
        break;
      }
    }
    return copied;
  }

  ShoppingCartModel? _cartWithout(String itemKey) {
    final cart = state.data;
    if (cart == null) return null;

    final copied = ShoppingCartModel.fromJson(cart.toJson());
    copied.data?.removeWhere((cartItem) => _itemKey(cartItem) == itemKey);
    return copied;
  }
}

final shoppingCartProvider =
    StateNotifierProvider<ShoppingCartProvider, ShoppingCartState>((ref) {
      return ShoppingCartProvider(
        remote: ShoppingCartRepository(
          resource: ShoppingCartApiService(apiClient: ApiClient()),
        ),
      );
    });
