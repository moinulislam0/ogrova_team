import 'package:flutter/material.dart';
import 'package:ogrova_team/core/resource/constant/image_manager.dart';
import 'package:ogrova_team/presentation/add_to-cart/view/widget/cart_item_card_widget.dart';
import 'package:ogrova_team/presentation/add_to-cart/view/widget/order_summary_card_widget.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Sample Product 265",
      "unitPrice": 884,
      "discountedPrice": 399,
      "quantity": 9,
      "pointsPerUnit": 153,
      "color": "RED",
      "size": "L",
      "savedAmount": 4365,
      "imageUrl": ImageManager.logo,
    },
  ];

  double get subtotal {
    return cartItems.fold(
      0,
      (sum, item) => sum + (item['discountedPrice'] * item['quantity']),
    );
  }

  int get totalPoints {
    return cartItems.fold(
      0,
      (sum, item) => sum + (item['pointsPerUnit'] * item['quantity'] as int),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Theme.of(context).colorScheme.onSurface),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            Row(
              children: [
                const Text(
                  "Shopping Cart",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    const TextSpan(text: "Total Items: "),
                    TextSpan(
                      text: "${cartItems.length}",
                      style: const TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CartItemCard(
                  item: item,
                  onIncrement: () => setState(() => item['quantity']++),
                  onDecrement: () => setState(() {
                    if (item['quantity'] > 1) item['quantity']--;
                  }),
                  onDelete: () => setState(() => cartItems.removeAt(index)),
                );
              },
            ),

            const SizedBox(height: 20),

            OrderSummaryCard(subtotal: subtotal, points: totalPoints),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
