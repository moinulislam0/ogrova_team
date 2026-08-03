import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrova_team/presentation/add_to-cart/view/widget/cart_item_card_widget.dart';
import 'package:ogrova_team/presentation/add_to-cart/view/widget/order_summary_card_widget.dart';
import 'package:ogrova_team/presentation/add_to-cart/viewModel/shopping_cart_provider.dart';
import 'package:ogrova_team/presentation/billing_address/view/screen/billing_address.dart';

class ShoppingCartScreen extends ConsumerStatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  ConsumerState<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends ConsumerState<ShoppingCartScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      ref.read(shoppingCartProvider.notifier).getCartData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shoppingCartProvider);
    final cartItems = state.data?.data ?? [];
    final checkoutReg = state.data?.reg ?? cartItems.firstOrNull?.reg ?? '';

    double subtotal = 0;
    int totalPoints = 0;
    for (var item in cartItems) {
      subtotal += item.totalPayableAmount;
      totalPoints += item.totalPoints;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            decoration: const BoxDecoration(
              color: Color(0xFF00A86B),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: const Text(
              "Shopping Cart",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: state.isLoading && cartItems.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : state.errorMessage != null
                ? Center(child: Text(state.errorMessage!))
                : cartItems.isEmpty
                ? const Center(
                    child: Text(
                      "Your cart is empty , At First Select Your Products",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () =>
                        ref.read(shoppingCartProvider.notifier).getCartData(),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  "Total Items: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "${cartItems.length}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF00A86B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            // Nested ListView adds top safe-area padding by
                            // default. Remove it so the first item sits right
                            // below the "Total Items" card.
                            padding: EdgeInsets.zero,
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final cartData = cartItems[index];
                              return CartItemCard(
                                item: cartData,
                                isQuantityUpdating: state.updatingItemKeys
                                    .contains(
                                      ref
                                          .read(shoppingCartProvider.notifier)
                                          .itemKey(cartData),
                                    ),
                                onIncrement: () {
                                  final currentQty = cartData.quantity ?? 1;
                                  ref
                                      .read(shoppingCartProvider.notifier)
                                      .updateQuantity(
                                        item: cartData,
                                        quantity: currentQty + 1,
                                      );
                                },
                                onDecrement: () {
                                  final currentQty = cartData.quantity ?? 1;
                                  if (currentQty > 1) {
                                    ref
                                        .read(shoppingCartProvider.notifier)
                                        .updateQuantity(
                                          item: cartData,
                                          quantity: currentQty - 1,
                                        );
                                  }
                                },
                                onDelete: () {
                                  ref
                                      .read(shoppingCartProvider.notifier)
                                      .deleteItem(cartData);
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
          ),

          if (cartItems.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: OrderSummaryCard(
                subtotal: subtotal,
                points: totalPoints,
                isCheckingOut: state.isCheckingOut,
                reg: state.data?.reg.toString() ?? '',
                onCheckout: () async {
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BillingAddress(
                          reg: state.data?.reg.toString() ?? '',
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}
