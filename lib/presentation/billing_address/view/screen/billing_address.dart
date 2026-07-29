import 'package:flutter/material.dart';
import 'package:ogrova_team/presentation/billing_address/view/screen/add_new_address.dart';

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

class AddressCard extends StatelessWidget {
  final String label, name, phone, address;
  final bool isDefault, isSelected;
  final VoidCallback onTap;

  const AddressCard({
    super.key,
    required this.label,
    required this.name,
    required this.phone,
    required this.address,
    required this.isDefault,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? const Color(0xFF00A86B) : Colors.grey.shade200,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                if (isDefault)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "DEFAULT",
                      style: TextStyle(
                        color: Color(0xFF00A86B),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  color: isSelected ? const Color(0xFF00A86B) : Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.phone_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 5),
                Text(phone, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              address,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 13,
                height: 1.4,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.delete_outline,
                color: Colors.blueGrey[200],
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentDetailsSection extends StatelessWidget {
  const PaymentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Payment Details",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF00A86B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _row("Subtotal", "৳ 3,704"),
        _row("Shipping", "৳ 120", isGreen: true),
        _row("Point", "1,391 pts", isBold: true),
        _row("Estimated Tax", "৳ 0"),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Have a coupon or promo code?",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.local_offer_outlined),
                        hintText: "Enter coupon code",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A86B),
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Apply",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _row(
    String label,
    String value, {
    bool isGreen = false,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isGreen ? const Color(0xFF00A86B) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
