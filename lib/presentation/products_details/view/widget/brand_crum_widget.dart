import 'package:flutter/material.dart';

class BreadcrumbWidget extends StatelessWidget {
  const BreadcrumbWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          "SHOP",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(Icons.circle, size: 4, color: Colors.grey),
        ),
        Text(
          "ELECTRONICS",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
