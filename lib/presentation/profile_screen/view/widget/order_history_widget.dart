import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ogrova_team/presentation/profile_screen/view/widget/order_widet.dart';
import 'package:ogrova_team/presentation/profile_screen/viewModel/order_details_provider.dart';

const Color kPrimary = Color(0xFF00A86B);
const Color kTextMuted = Color(0xFF64748B);

class OrderHistoryScreen extends ConsumerStatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  ConsumerState<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends ConsumerState<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => ref.read(orderDetailsProvider.notifier).getdata());
  }

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "";
    try {
      DateTime dt = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(dt);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderDetailsProvider);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: colors.surface,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.shopping_bag_rounded,
                            color: kPrimary,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order History",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: colors.onSurface,
                              ),
                            ),
                            Text(
                              "Manage and track your recent orders",
                              style: TextStyle(
                                fontSize: 12,
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        ref.read(orderDetailsProvider.notifier).getdata(),
                    icon: const Icon(Icons.refresh_rounded),
                  ),
                ],
              ),
            ),

            // Orders List
            Expanded(
              child: state.isloading
                  ? const Center(
                      child: CircularProgressIndicator(color: kPrimary),
                    )
                  : state.data?.data?.data == null ||
                        state.data!.data!.data!.isEmpty
                  ? const Center(child: Text("No orders found"))
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      itemCount: state.data?.data?.data?.length ?? 0,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final order = state.data!.data!.data![index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => OrderDetailsScreen(
                                  orderId: order.reg ?? "",
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: colors.surface,
                              borderRadius: BorderRadius.circular(18),

                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Top row: Order ID + Status
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            order.reg ?? "",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: kPrimary,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            "+${order.point ?? 0} points earned",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.orange.shade700,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        order.status ?? "Pending",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.orange.shade700,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Icon(
                                      Icons.chevron_right_rounded,
                                      color: Color(0xFFCBD5E1),
                                      size: 22,
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 14),
                                Divider(
                                  height: 1,
                                  color: colors.outlineVariant,
                                ),
                                const SizedBox(height: 14),

                                // Bottom info row
                                Row(
                                  children: [
                                    Flexible(
                                      child: _infoChip(
                                        Icons.calendar_today_outlined,
                                        formatDate(order.date),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Flexible(
                                      child: _infoChip(
                                        Icons.payments_outlined,
                                        "${order.paymentMethod ?? ""} · ${order.paymentStatus ?? ""}",
                                      ),
                                    ),
                                    const SizedBox(width: 80),
                                    Text(
                                      "${order.currency ?? "BDT"} ${order.payableAmount ?? "0"}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                        color: colors.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: kTextMuted),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              color: kTextMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
