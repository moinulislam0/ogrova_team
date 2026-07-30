import 'package:flutter/material.dart';
import 'package:ogrova_team/core/resource/constant/color_manager.dart';

class StockAndSkuWidget extends StatelessWidget {
  const StockAndSkuWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            children: [
              Icon(Icons.circle, size: 8, color: Colors.green),
              SizedBox(width: 6),
              Text(
                "In Stock",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 15),
        const Text(
          "SKU: PRD-SKU-48SLA5",
          style: TextStyle(color: ColorManager.primary, fontSize: 14),
        ),
      ],
    );
  }
}
