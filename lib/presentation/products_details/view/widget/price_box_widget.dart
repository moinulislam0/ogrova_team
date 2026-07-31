import 'package:flutter/material.dart';

class PriceBoxWidget extends StatelessWidget {
  final double currentPrice;
  final double oldPrice;

  const PriceBoxWidget({
    super.key,
    required this.currentPrice,
    required this.oldPrice,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "TOTAL PRICE", // মার্কেট প্রাইস থেকে টোটাল প্রাইস নাম দিলাম
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "৳${currentPrice.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00A86B),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      "৳${oldPrice.toStringAsFixed(0)}",
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "Save ৳${(oldPrice - currentPrice).toStringAsFixed(0)}",
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: 25,
            backgroundColor: colors.surfaceContainerHighest,
            child: Icon(Icons.sell_outlined, color: colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
