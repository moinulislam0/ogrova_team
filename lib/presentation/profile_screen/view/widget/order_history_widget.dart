import 'package:flutter/material.dart';
import 'package:ogrova_team/core/resource/constant/color_manager.dart';
import 'package:ogrova_team/presentation/profile_screen/view/widget/order_widet.dart';

const Color kPrimary = Color(0xFF00A86B);
const Color kPrimaryDark = Color(0xFF008C5A);
const Color kBg = Color(0xFFF1F5F9);
const Color kTextDark = Color(0xFF0F172A);
const Color kTextMuted = Color(0xFF64748B);

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        "id": "#ORD-02-002",
        "date": "Jul 30, 2026",
        "payment": "COD",
        "paymentStatus": "PENDING",
        "total": "BDT 145",
        "status": "Pending",
        "points": "+97 points earned",
      },
      {
        "id": "#ORD-02-001",
        "date": "Jul 29, 2026",
        "payment": "COD",
        "paymentStatus": "PENDING",
        "total": "BDT 3,824",
        "status": "Pending",
        "points": "+1391 points earned",
      },
    ];

    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorManager.primary,
                Color(0xFFF0FDF6),
                Color(0xFFF8FAFC),
                Color(0xFFF1F5F9),
              ],
              stops: [0.0, 0.3, 0.7, 1.0],
            ),
          ),
          child: Column(
            children: [
              // Header
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
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.shopping_bag_rounded,
                              color: kPrimary,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order History",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: kTextDark,
                                ),
                              ),
                              Text(
                                "Manage and track your recent orders",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: kTextMuted,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.refresh_rounded,
                        color: kTextMuted,
                      ),
                    ),
                  ],
                ),
              ),

              // Orders List
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  itemCount: orders.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final o = orders[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                OrderDetailsScreen(orderId: o["id"]!),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
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
                            // Top row: Order ID + Status + Arrow
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        o["id"]!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: kPrimary,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        o["points"]!,
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
                                    o["status"]!,
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
                            const Divider(height: 1, color: Color(0xFFF1F5F9)),
                            const SizedBox(height: 14),

                            // Bottom info row
                            Row(
                              children: [
                                _infoChip(
                                  Icons.calendar_today_outlined,
                                  o["date"]!,
                                ),
                                const SizedBox(width: 16),
                                _infoChip(
                                  Icons.payments_outlined,
                                  "${o["payment"]} · ${o["paymentStatus"]}",
                                ),
                                const Spacer(),
                                Text(
                                  o["total"]!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                    color: kTextDark,
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

              // Pagination
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       const Text(
              //         "Showing 1 – 2 of 2",
              //         style: TextStyle(fontSize: 12, color: kTextMuted),
              //       ),
              //       Row(
              //         children: [
              //           // _pageBtn(Icons.first_page_rounded, false),
              //           // _pageBtn(Icons.chevron_left_rounded, false),
              //           Container(
              //             width: 32,
              //             height: 32,
              //             alignment: Alignment.center,
              //             decoration: BoxDecoration(
              //               color: kTextDark,
              //               borderRadius: BorderRadius.circular(8),
              //             ),
              //             child: const Text(
              //               "1",
              //               style: TextStyle(
              //                 color: Colors.white,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //           ),
              //           // _pageBtn(Icons.chevron_right_rounded, false),
              //           // _pageBtn(Icons.last_page_rounded, false),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: kTextMuted),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: kTextMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Widget _pageBtn(IconData icon, bool enabled) {
  //   return IconButton(
  //     onPressed: enabled ? () {} : null,
  //     icon: Icon(
  //       icon,
  //       size: 20,
  //       color: enabled ? kTextDark : Colors.grey.shade300,
  //     ),
  //     padding: EdgeInsets.zero,
  //     constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
  //   );
  // }
}
