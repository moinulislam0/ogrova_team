import 'package:flutter/material.dart';
import 'package:ogrova_team/core/resource/constant/color_manager.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String image; // IconData এর বদলে String image

  const CategoryItem({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: ColorManager.primary.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorManager.primary.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: ClipOval(
              child: image.startsWith('http')
                  ? Image.network(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => 
                        const Icon(Icons.category_outlined, color: ColorManager.primary),
                    )
                  : (image.isNotEmpty 
                      ? Image.asset(
                          image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => 
                            const Icon(Icons.category_outlined, color: ColorManager.primary),
                        )
                      : const Icon(Icons.category_outlined, color: ColorManager.primary)),
            ),
          ),
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
    );
  }
}