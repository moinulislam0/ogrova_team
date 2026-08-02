import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrova_team/core/resource/constant/color_manager.dart';
import 'package:ogrova_team/presentation/add_to-cart/viewModel/shopping_cart_provider.dart';
import 'package:ogrova_team/presentation/billing_address/view/screen/add_new_address.dart';
import 'package:ogrova_team/presentation/billing_address/view/widget/address_card_widget.dart';
import 'package:ogrova_team/presentation/billing_address/view/widget/custom_pay_button_widget.dart';
import 'package:ogrova_team/presentation/billing_address/view/widget/payment_details_widget.dart';

import 'package:ogrova_team/presentation/billing_address/viewModel/billing_address_provider.dart';

class BillingAddress extends ConsumerStatefulWidget {
  final String reg;
  const BillingAddress({super.key, required this.reg});

  @override
  ConsumerState<BillingAddress> createState() => _BillingAddressState();
}

class _BillingAddressState extends ConsumerState<BillingAddress> {
  int? selectedAddressId;
  String selectedPayment = "cod";
  double couponDiscount = 0;

  @override
  void initState() {
    super.initState();

    Future.microtask(() => ref.read(billingAddressProvider.notifier).getPublicProducts());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shoppingCartProvider);
    final addressState = ref.watch(billingAddressProvider);

    final cartItems = state.data?.data ?? [];
    final addresses = addressState.data?.data ?? [];

    double subtotal = 0;
    int totalPoints = 0;
    for (var item in cartItems) {
      subtotal += item.totalPayableAmount;
      totalPoints += item.totalPoints;
    }

    const double tax = 0.0;
    final double shipping = double.tryParse(
          addresses.isNotEmpty ? addresses.first.deliveryCharge ?? '' : '',
        ) ??
        0;
    final double totalAmount = (subtotal + tax + shipping - couponDiscount)
        .clamp(0, double.infinity)
        .toDouble();

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

            if (addressState.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (addresses.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text("No saved addresses found."),
              )
            else
              Column(
                children: List.generate(addresses.length, (index) {
                  final address = addresses[index];
                  if (selectedAddressId == null && (address.isDefault ?? false)) {
                    selectedAddressId = address.id;
                  }

                  return AddressCard(
                    label: address.label?.toUpperCase() ?? "ADDRESS",
                    name: address.recipientName ?? "No Name",
                    phone: address.phone ?? "",
                    address: "${address.address}, ${address.upazila?.name}, ${address.district?.name}",
                    isDefault: address.isDefault ?? false,
                    isSelected: selectedAddressId == address.id,
                    onTap: () => setState(() => selectedAddressId = address.id),
                  );
                }),
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
              shipping: shipping,
              subtotal: subtotal,
              totalPoints: totalPoints.toDouble(),
              tax: tax,
              discountAmount: couponDiscount,
              totalAmount: totalAmount,
              onDiscountChanged: (discount) {
                setState(() => couponDiscount = discount);
              },
            ),
            const SizedBox(height: 200),
          ],
        ),
      ),
      bottomSheet: BottomPayButton(
        totalAmount: totalAmount, 
        onPressed: () {},
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
    ).then((value) {
      ref.read(billingAddressProvider.notifier).getPublicProducts();
    });
  }
}
