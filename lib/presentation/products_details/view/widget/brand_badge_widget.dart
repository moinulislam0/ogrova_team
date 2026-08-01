import 'package:flutter/material.dart';

class BrandAndBadges extends StatelessWidget {
   final String brandName;
  final String categoryName;
  final String? discount;
  const BrandAndBadges({super.key, required this.brandName, required this.categoryName, this.discount});
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Text(brandName.toUpperCase(), style: const TextStyle(color: Color(0xFF00A86B), fontWeight: FontWeight.bold)),
        const SizedBox(width: 10),
        Text(categoryName.toUpperCase(), style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
        const Spacer(),
        if (discount != null && discount != "0") _badge("৳$discount OFF"),
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
