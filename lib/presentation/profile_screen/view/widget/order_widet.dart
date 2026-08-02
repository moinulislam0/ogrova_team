import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart'; // ডেট ফরম্যাট করার জন্য
import 'package:ogrova_team/presentation/profile_screen/viewModel/order_details_provider.dart';

const Color kPrimary = Color(0xFF00A86B);

class OrderDetailsScreen extends ConsumerStatefulWidget {
  final String orderId;
  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  ConsumerState<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends ConsumerState<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(orderDetailsProvider.notifier).getdata());
  }

  // ডেট ফরম্যাট করার ফাংশন - এখানে N/A এর বদলে Pending করা হয়েছে
  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "Pending";
    try {
      DateTime dt = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(dt);
    } catch (e) {
      // যদি স্ট্রিংটি ডেট না হয় তবে যা আছে তাই দেখাবে অথবা স্লিট করে তারিখ নিবে
      return dateStr.contains('T') ? dateStr.split('T')[0] : dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderDetailsProvider);
    final colors = Theme.of(context).colorScheme;

    if (state.isloading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: kPrimary)),
      );
    }

    if (state.errormessage != null) {
      return Scaffold(body: Center(child: Text(state.errormessage!)));
    }

    final list = state.data?.data?.data;
    final order = list?.firstWhere(
      (element) => element.reg == widget.orderId,
      orElse: () => list!.first,
    );

    if (order == null) {
      return const Scaffold(
        body: Center(child: Text("No order details found")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          constraints: const BoxConstraints(maxWidth: 480),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: colors.outlineVariant),
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
                          Text(
                            "Order Details",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: colors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Order Ref: ${order.reg ?? ""}",
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
                          color: colors.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            _infoItem(
                              context,
                              "Order Date",
                              formatDate(order.date),
                            ),
                            _infoItem(
                              context,
                              "Order Status",
                              order.status ?? "",
                              isStatus: true,
                            ),
                            _infoItem(
                              context,
                              "Payment Method",
                              order.paymentMethod ?? "",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Timeline
                      Text(
                        "Order Timeline",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: colors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _buildTimeline(context, order),
                      const SizedBox(height: 24),

                      // Shipping Details
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: colors.outlineVariant),
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Shipping Details",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: colors.onSurface,
                                      ),
                                    ),
                                    Text(
                                      "Customer delivery information",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: colors.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(height: 24),
                            _shipRow(
                              context,
                              Icons.person_outline,
                              "RECIPIENT",
                              order.contactName ?? "",
                            ),
                            const SizedBox(height: 12),
                            _shipRow(
                              context,
                              Icons.phone_outlined,
                              "PHONE",
                              order.contactNumber ?? "",
                            ),
                            const SizedBox(height: 12),
                            _shipRow(
                              context,
                              Icons.location_on_outlined,
                              "ADDRESS",
                              order.shippingAddress ?? "",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Items Section
                      Text(
                        "ITEMS ORDERED",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: colors.onSurfaceVariant,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...order.items!.map((item) {
                        double itemTotal =
                            (double.tryParse(item.price ?? '0') ?? 0) *
                            (item.quantity ?? 0);

                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: colors.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product?.name ?? "N/A",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: colors.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "Qty : ${item.quantity} × ৳${item.price}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: colors.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "৳${itemTotal.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: colors.onSurface,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 20),

                      // Summary
                      _summaryRow("Subtotal", "৳${order.amount}"),
                      _summaryRow(
                        "Discount",
                        "- ৳${order.discount}",
                        isDiscount: true,
                      ),
                      _summaryRow(
                        "Shipping Charge",
                        "৳${order.shippingCharge}",
                      ),
                      const Divider(height: 24),
                      _summaryRow(
                        "Total Payable",
                        "৳${order.payableAmount}",
                        isTotal: true,
                      ),
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
                      side: BorderSide(color: colors.outlineVariant),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      "Close",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: colors.onSurface,
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

  Widget _infoItem(
    BuildContext context,
    String label,
    String value, {
    bool isStatus = false,
  }) {
    final colors = Theme.of(context).colorScheme;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 11, color: colors.onSurfaceVariant),
          ),
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
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: colors.onSurface,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context, dynamic order) {
    final colors = Theme.of(context).colorScheme;
    final steps = [
      {
        "title": "Placed",
        "date": formatDate(order.createdAt),
        "done": true,
        "icon": Icons.shopping_cart_checkout,
      },
      {
        "title": "Confirmed",
        "date": formatDate(order.confirmedAt),
        "done": order.confirmedAt != null,
        "icon": Icons.fact_check_outlined,
      },
      {
        "title": "Processing",
        "date": formatDate(order.processingAt),
        "done": order.processingAt != null,
        "icon": Icons.sync,
      },
      {
        "title": "Picked",
        "date": formatDate(order.pickedAt),
        "done": order.pickedAt != null,
        "icon": Icons.inventory_2_outlined,
      },
      {
        "title": "Shipped",
        "date": formatDate(order.shippedAt),
        "done": order.shippedAt != null,
        "icon": Icons.local_shipping_outlined,
      },
      {
        "title": "Delivered",
        "date": formatDate(order.deliveredAt),
        "done": order.deliveredAt != null,
        "icon": Icons.task_alt,
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            return Container(
              width: 28,
              height: 2,
              color: colors.outlineVariant,
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
                  color: done ? kPrimary : colors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: done ? kPrimary : colors.outline,
                    width: 2,
                  ),
                ),
                child: Icon(
                  step["icon"] as IconData,
                  size: 16,
                  color: done ? Colors.white : colors.outline,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                step["title"] as String,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: done ? colors.onSurface : colors.onSurfaceVariant,
                ),
              ),
              Text(
                step["date"] as String,
                style: TextStyle(
                  fontSize: 10,
                  color: done ? kPrimary : colors.onSurfaceVariant,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _shipRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: colors.onSurfaceVariant),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: colors.onSurfaceVariant,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colors.onSurface,
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
              color: isDiscount ? kPrimary : null,
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
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
