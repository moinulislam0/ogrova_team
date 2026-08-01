import 'package:flutter/material.dart';
import 'package:ogrova_team/core/resource/constant/image_manager.dart';
import 'package:ogrova_team/data/models/public_products_model.dart'; // মডেল ইমপোর্ট করুন
import 'package:ogrova_team/presentation/products_details/view/screen/products_details_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProductDetailsScreen()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isDark ? const Color(0xFF3A4B43) : const Color(0xFFE2E8F0),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.discount != null)
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00A86B),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    product.slug ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 5),

            // Image Section
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest,
                ),
                child: product.images != null && product.images!.isNotEmpty
                    ? Image.network(
                        product.images![0].toString(),
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Image.asset(
                          ImageManager.products,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Image.asset(ImageManager.products, fit: BoxFit.contain),
              ),
            ),

            // Details Section
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.category?.name ??
                              "No Category", // ডাইনামিক ক্যাটাগরি
                          style: TextStyle(
                            color: colors.onSurfaceVariant,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.military_tech,
                              size: 12,
                              color: Color(0xFF00A86B),
                            ),
                            Text(
                              "${product.point ?? 0} Pts",
                              style: const TextStyle(
                                color: Color(0xFF00A86B),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(
                    product.name ?? "Unknown Product",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "৳${product.price}",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: colors.onSurfaceVariant,
                          fontSize: 14,
                        ),
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "৳",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${product.discount}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
