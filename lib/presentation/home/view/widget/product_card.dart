import 'package:flutter/material.dart';
import 'package:ogrova_team/core/resource/constant/image_manager.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(ImageManager.logo, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 5, left: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFF00A86B), borderRadius: BorderRadius.circular(4)),
                    child: const Text("-76% OFF", style: TextStyle(color: Colors.white, fontSize: 9)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Sample Product 30", maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 4),
                const Text("32 Pts", style: TextStyle(color: Color(0xFF00A86B), fontSize: 10, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("৳166", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00A86B))),
                    const SizedBox(width: 5),
                    const Text("৳418", style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 11)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}