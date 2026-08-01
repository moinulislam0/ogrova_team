import 'package:flutter/material.dart';

class ProductImageSection extends StatelessWidget {
  final String image;
  const ProductImageSection({super.key, required this.image});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 350,
            color: Colors.grey.shade200,
            child: Image.asset(image),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                "-55% OFF X",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
