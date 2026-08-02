import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod ইম্পোর্ট করা হয়েছে
import 'package:ogrova_team/core/resource/constant/color_manager.dart';
import 'package:ogrova_team/presentation/add_to-cart/viewModel/shopping_cart_provider.dart'; // Provider ইম্পোর্ট করা হয়েছে
import 'package:ogrova_team/presentation/billing_address/view/screen/add_new_address.dart';
import 'package:ogrova_team/presentation/billing_address/view/widget/address_card_widget.dart';
import 'package:ogrova_team/presentation/billing_address/view/widget/custom_pay_button_widget.dart';
import 'package:ogrova_team/presentation/billing_address/view/widget/payment_details_widget.dart';

class BillingAddress extends ConsumerStatefulWidget { // StatefulWidget থেকে ConsumerStatefulWidget এ পরিবর্তন
  final String reg;
  const BillingAddress({super.key, required this.reg});

  @override
  ConsumerState<BillingAddress> createState() => _BillingAddressState();
}

class _BillingAddressState extends ConsumerState<BillingAddress> {
  int selectedAddress = 1; // Default selected address index
  String selectedPayment = "cod";

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shoppingCartProvider);
    final cartItems = state.data?.data ?? [];

    double subtotal = 0;
    int totalPoints = 0;
    for (var item in cartItems) {
      subtotal += item.totalPayableAmount;
    
      totalPoints += item.totalPoints;
    }
    
    double tax = 0.0; 
    double shipping = 0.0;

   
    double totalAmount = subtotal + tax + shipping;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          "Checkout",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: BackButton(color: Theme.of(context).colorScheme.onSurface),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Billing Address Title
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                children: [
                  const TextSpan(text: "Billing "),
                  TextSpan(
                    text: "Address",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Shipping Address Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "SHIPPING ADDRESS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _showAddAddressModal(context),
                  icon: const Icon(
                    Icons.add,
                    size: 18,
                    color: ColorManager.primary,
                  ),
                  label: const Text(
                    "Add New Address",
                    style: TextStyle(
                      color: ColorManager.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // Address Cards
            AddressCard(
              label: "HOME",
              name: "Samim Hossain",
              phone: "01712345678",
              address:
                  "House #12, Road #5, Dhanmondi, Demra, Debidwar, Comilla, Chattagram - 1209",
              isDefault: true,
              isSelected: selectedAddress == 0,
              onTap: () => setState(() => selectedAddress = 0),
            ),
            AddressCard(
              label: "OFFICE",
              name: "Samim Hossain",
              phone: "01812345678",
              address:
                  "Level 5, Business Center, Banani, Dhaka Cantt., Barura, Comilla, Chattagram - 1213",
              isDefault: false,
              isSelected: selectedAddress == 1,
              onTap: () => setState(() => selectedAddress = 1),
            ),

            const SizedBox(height: 20),
            const Text(
              "PAYMENT METHOD *",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 10),

            // Payment Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF00A86B)),
              ),
              child: RadioListTile(
                value: "cod",
                groupValue: selectedPayment,
                onChanged: (val) {
                  setState(() {
                    selectedPayment = val.toString();
                  });
                },
                activeColor: const Color(0xFF00A86B),
                title: const Text(
                  "Cash on Delivery",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  "Pay the price after receiving the product.",
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "Remarks / Note (Optional)",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Type your external note here...",
                fillColor: Theme.of(context).colorScheme.surface,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
              ),
            ),

            const SizedBox(height: 30),
           
            PaymentDetailsSection(
              shipping: shipping.toString(),
              subtotal: subtotal.toString(),
              totalPoints: totalPoints.toDouble().toString(),
              tax: tax.toString(),
            ),
            const SizedBox(height: 200), // Space for bottom button
          ],
        ),
      ),
      bottomSheet: BottomPayButton(
        totalAmount: totalAmount, 
        onPressed: () {
        
        },
      ),
    );
  }

  void _showAddAddressModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const AddAddressModal(),
    );
  }
}