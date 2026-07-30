import 'package:flutter/material.dart';
import 'package:ogrova_team/presentation/billing_address/view/screen/add_new_address.dart';
import 'package:ogrova_team/presentation/billing_address/view/widget/address_card_widget.dart';
import 'package:ogrova_team/presentation/billing_address/view/widget/custom_pay_button_widget.dart';
import 'package:ogrova_team/presentation/billing_address/view/widget/payment_details_widget.dart';

class BillingAddress extends StatefulWidget {
  const BillingAddress({super.key});

  @override
  State<BillingAddress> createState() => _BillingAddressState();
}

class _BillingAddressState extends State<BillingAddress> {
  int selectedAddress = 1; // Default selected address index
  String selectedPayment = "cod";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Checkout", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Billing Address Title
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(text: "Billing "),
                  TextSpan(
                    text: "Address",
                    style: TextStyle(color: Color(0xFF00A86B)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Shipping Address Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "SHIPPING ADDRESS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _showAddAddressModal(context),
                  icon: const Icon(
                    Icons.add,
                    size: 18,
                    color: Color(0xFF00A86B),
                  ),
                  label: const Text(
                    "Add New Address",
                    style: TextStyle(
                      color: Color(0xFF00A86B),
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
                color: const Color(0xFFE8F5E9).withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF00A86B)),
              ),
              child: RadioListTile(
                value: "cod",
                groupValue: selectedPayment,
                onChanged: (val) {},
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
                fillColor: Colors.white,
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
            const PaymentDetailsSection(),
            const SizedBox(height: 200), // Space for bottom button
          ],
        ),
      ),
      bottomSheet: BottomPayButton(),
    );
  }

  // Add New Address Modal Function
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

// --- Reusable Widgets ---

