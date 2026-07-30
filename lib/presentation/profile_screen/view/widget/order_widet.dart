import 'package:flutter/material.dart';
const Color kPrimary = Color(0xFF00A86B);
const Color kPrimaryDark = Color(0xFF008C5A);
const Color kBg = Color(0xFFF1F5F9);
const Color kTextDark = Color(0xFF0F172A);
const Color kTextMuted = Color(0xFF64748B);
class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          constraints: const BoxConstraints(maxWidth: 480),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 12, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Order Details",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: kTextDark,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Order Ref: $orderId",
                            style: const TextStyle(
                              fontSize: 13,
                              color: kPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
              ),

              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top info cards
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            _infoItem("Order Date", "Jul 30, 2026"),
                            _infoItem(
                              "Order Status",
                              "Pending",
                              isStatus: true,
                            ),
                            _infoItem("Payment Method", "COD (PENDING)"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Timeline
                      const Text(
                        "Order Timeline",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _buildTimeline(),
                      const SizedBox(height: 24),

                      // Shipping Details
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: kPrimary.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.local_shipping_outlined,
                                    color: kPrimary,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Shipping Details",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "Customer delivery information",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: kTextMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(height: 24),
                            _shipRow(
                              Icons.person_outline,
                              "RECIPIENT",
                              "Samim Hossain",
                            ),
                            const SizedBox(height: 12),
                            _shipRow(
                              Icons.phone_outlined,
                              "PHONE",
                              "01712345678",
                            ),
                            const SizedBox(height: 12),
                            _shipRow(
                              Icons.location_on_outlined,
                              "ADDRESS",
                              "House #12, Road #5, Dhanmondi",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Items
                      const Text(
                        "ITEMS ORDERED",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: kTextMuted,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sample Product 284",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "Qty : 1 × ৳148.00",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: kTextMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "৳148.00",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Summary
                      _summaryRow("Subtotal", "৳148.00"),
                      _summaryRow("Discount", "- ৳123.00", isDiscount: true),
                      _summaryRow("Shipping Charge", "৳120.00"),
                      const Divider(height: 24),
                      _summaryRow("Total Payable", "৳145.00", isTotal: true),
                    ],
                  ),
                ),
              ),

              // Close button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      "Close",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kTextDark,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoItem(String label, String value, {bool isStatus = false}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: kTextMuted)),
          const SizedBox(height: 4),
          isStatus
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange.shade700,
                    ),
                  ),
                )
              : Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    final steps = [
      {"title": "Placed", "date": "Jul 30, 2026", "done": true},
      {"title": "Confirmed", "date": "Pending", "done": false},
      {"title": "Processing", "date": "Pending", "done": false},
      {"title": "Picked", "date": "Pending", "done": false},
      {"title": "Shipped", "date": "Pending", "done": false},
      {"title": "Out for delivery", "date": "Pending", "done": false},
      {"title": "Delivered", "date": "Pending", "done": false},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            return Container(
              width: 28,
              height: 2,
              color: const Color(0xFFE2E8F0),
            );
          }
          final step = steps[i ~/ 2];
          final done = step["done"] as bool;
          return Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: done ? kPrimary : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: done ? kPrimary : const Color(0xFFCBD5E1),
                    width: 2,
                  ),
                ),
                child: Icon(
                  done ? Icons.shopping_bag : Icons.circle_outlined,
                  size: 16,
                  color: done ? Colors.white : const Color(0xFFCBD5E1),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                step["title"] as String,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: done ? kTextDark : kTextMuted,
                ),
              ),
              Text(
                step["date"] as String,
                style: TextStyle(
                  fontSize: 10,
                  color: done ? kPrimary : kTextMuted,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _shipRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: kTextMuted),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: kTextMuted,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: kTextDark,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _summaryRow(
    String label,
    String value, {
    bool isDiscount = false,
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 15 : 13,
              fontWeight: isTotal ? FontWeight.w800 : FontWeight.w500,
              color: isDiscount ? kPrimary : kTextDark,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 13,
              fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
              color: isTotal
                  ? kPrimary
                  : isDiscount
                  ? kPrimary
                  : kTextDark,
            ),
          ),
        ],
      ),
    );
  }
}
