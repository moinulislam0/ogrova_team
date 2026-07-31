import 'package:flutter/material.dart';
import 'package:ogrova_team/core/resource/constant/color_manager.dart';

class VariantCard extends StatelessWidget {
  final String title, price, left;
  final Color color;
  final bool isSelected;
  const VariantCard({
    super.key,
    required this.title,
    required this.price,
    required this.left,
    required this.color,
    required this.isSelected,
  });
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isSelected
            ? ColorManager.primary.withValues(alpha: .5)
            : colors.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected
              ? ColorManager.primary.withValues(alpha: .5)
              : colors.outlineVariant,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, color: color, size: 18),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: colors.onSurface,
              ),
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: ColorManager.primary,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            left,
            style: const TextStyle(
              color: ColorManager.primary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
