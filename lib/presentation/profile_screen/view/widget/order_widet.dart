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

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "Pending";
    try {
      DateTime dt = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(dt);
    } catch (e) {
      return dateStr.contains('T') ? dateStr.split('T')[0] : dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderDetailsProvider);
    final colors = Theme.of(context).colorScheme;

    if (state.isloading) {
      return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.4),
        body: const Center(
          child: CircularProgressIndicator(color: kPrimary, strokeWidth: 3),
        ),
      );
    }

    if (state.errormessage != null) {
      return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.4),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  color: Colors.redAccent,
                  size: 48,
                ),
                const SizedBox(height: 12),
                Text(
                  state.errormessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final list = state.data?.data?.data;
    final order = list?.firstWhere(
      (element) => element.reg == widget.orderId,
      orElse: () => list!.first,
    );

    if (order == null) {
      return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.4),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text("No order details found"),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          constraints: const BoxConstraints(maxWidth: 480),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: colors.outlineVariant.withOpacity(0.5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Details",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: colors.onSurface,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: kPrimary.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "Order Ref: ${order.reg ?? ""}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: kPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Material(
                      color: colors.surfaceContainerHighest.withOpacity(0.5),
                      shape: const CircleBorder(),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close_rounded, size: 20),
                        splashRadius: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, thickness: 1),

              Flexible(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top info cards
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerHighest.withOpacity(
                            0.4,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: colors.outlineVariant.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            _infoItem(
                              context,
                              "Order Date",
                              formatDate(order.createdAt),
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
                      const SizedBox(height: 24),

                      // Timeline
                      Row(
                        children: [
                          Icon(
                            Icons.timeline_rounded,
                            size: 18,
                            color: colors.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Order Timeline",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: colors.onSurface,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerHighest.withOpacity(
                            0.2,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: _buildTimeline(context, order),
                      ),
                      const SizedBox(height: 24),

                      // Shipping Details
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: colors.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: colors.outlineVariant.withOpacity(0.5),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: kPrimary.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.local_shipping_outlined,
                                    color: kPrimary,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Shipping Details",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: colors.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "Customer delivery information",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: colors.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Divider(height: 1),
                            ),
                            _shipRow(
                              context,
                              Icons.person_outline_rounded,
                              "RECIPIENT",
                              order.contactName ?? "",
                            ),
                            const SizedBox(height: 14),
                            _shipRow(
                              context,
                              Icons.phone_outlined,
                              "PHONE",
                              order.contactNumber ?? "",
                            ),
                            const SizedBox(height: 14),
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
                      Row(
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            size: 16,
                            color: colors.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "ITEMS ORDERED",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: colors.onSurfaceVariant,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...order.items!.map((item) {
                        double itemTotal =
                            (double.tryParse(item.price ?? '0') ?? 0) *
                            (item.quantity ?? 0);

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: colors.surfaceContainerHighest.withOpacity(
                              0.3,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: colors.outlineVariant.withOpacity(0.3),
                            ),
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
                                    const SizedBox(height: 4),
                                    Text(
                                      "Qty : ${item.quantity} × ৳${item.price}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
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
                                  fontSize: 15,
                                  color: colors.onSurface,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 16),

                      // Summary Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerHighest.withOpacity(
                            0.2,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
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
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Divider(height: 1),
                            ),
                            _summaryRow(
                              "Total Payable",
                              "৳${order.payableAmount}",
                              isTotal: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Close button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colors.outlineVariant),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Close",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
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
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 6),
          isStatus
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.amber.shade600.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.amber.shade900,
                    ),
                  ),
                )
              : Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
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
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            final isDone = steps[(i + 1) ~/ 2]["done"] as bool;
            return Container(
              margin: const EdgeInsets.only(top: 18),
              width: 32,
              height: 2,
              color: isDone ? kPrimary : colors.outlineVariant,
            );
          }
          final step = steps[i ~/ 2];
          final done = step["done"] as bool;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: done ? kPrimary : colors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: done ? kPrimary : colors.outline.withOpacity(0.5),
                    width: 2,
                  ),
                  boxShadow: done
                      ? [
                          BoxShadow(
                            color: kPrimary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  step["icon"] as IconData,
                  size: 18,
                  color: done ? Colors.white : colors.outline,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                step["title"] as String,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: done ? colors.onSurface : colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                step["date"] as String,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: done
                      ? kPrimary
                      : colors.onSurfaceVariant.withOpacity(0.7),
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
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: colors.surfaceContainerHighest.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: colors.onSurfaceVariant),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: colors.onSurfaceVariant,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: colors.onSurface,
                  height: 1.3,
                ),
              ),
            ],
          ),
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
      padding: const EdgeInsets.symmetric(vertical: 5),
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
              fontSize: isTotal ? 17 : 13,
              fontWeight: isTotal ? FontWeight.w800 : FontWeight.w700,
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
