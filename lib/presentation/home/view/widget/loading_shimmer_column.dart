import 'package:flutter/material.dart';

class LoadingShimmerColumn extends StatelessWidget {
  const LoadingShimmerColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        2,
        (index) => Container(
          height: 80,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
