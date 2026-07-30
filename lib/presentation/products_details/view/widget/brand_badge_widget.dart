import 'package:flutter/material.dart';

class BrandAndBadges extends StatelessWidget {
  const BrandAndBadges({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "H & M",
          style: TextStyle(
            color: Color(0xFF00A86B),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          "ELECTRONICS",
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const Spacer(),
        _badge("-55% OFF"),
        const SizedBox(width: 8),
        _badge("SALE", icon: Icons.local_fire_department),
      ],
    );
  }

  Widget _badge(String text, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          if (icon != null)
            Icon(icon, size: 14, color: const Color(0xFF00A86B)),
          const SizedBox(width: 3),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF00A86B),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
