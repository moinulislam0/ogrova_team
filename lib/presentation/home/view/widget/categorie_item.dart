import 'package:flutter/material.dart';
import 'package:ogrova_team/core/resource/constant/color_manager.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final int id;
  final String? image;
  final VoidCallback ontap;

  const CategoryItem({
    super.key,
    required this.title,
    this.image,
    required this.id,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: ontap,
        child: Column(
          children: [
          
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: ColorManager.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
