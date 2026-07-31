import 'package:flutter/material.dart';
import 'package:ogrova_team/core/resource/constant/color_manager.dart';

class DeliveryInfoWidget extends StatelessWidget {
  const DeliveryInfoWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            child: Icon(Icons.flash_on, color: colors.onPrimary, size: 20),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "EXPRESS DELIVERY AVAILABLE",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Order within 02h 45m to receive your package by tomorrow.",
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
