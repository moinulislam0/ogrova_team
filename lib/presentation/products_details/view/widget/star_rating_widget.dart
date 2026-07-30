import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  const StarRatingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => const Icon(Icons.star_outline, color: Colors.grey, size: 30),
      ),
    );
  }
}
