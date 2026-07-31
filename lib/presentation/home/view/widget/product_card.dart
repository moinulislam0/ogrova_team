import 'package:flutter/material.dart';
import 'package:ogrova_team/core/resource/constant/image_manager.dart';
import 'package:ogrova_team/presentation/products_details/view/screen/products_details_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

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
            color: isDark ? Color(0xFF3A4B43) : Color(0xFFE2E8F0),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Offer Badge
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
                child: const Text(
                  "-95% OFF",
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
                child: Image.asset(ImageManager.logo, fit: BoxFit.contain),
              ),
            ),

            // Details Section
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "ELECTRONICS ",
                          style: TextStyle(
                            color: colors.onSurfaceVariant,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
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
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.military_tech,
                              size: 12,
                              color: Color(0xFF00A86B),
                            ),
                            SizedBox(width: 2),
                            Text(
                              "129 Pts",
                              style: TextStyle(
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

                  const Text(
                    "Sample Product 308 Long Name Example ",

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: List.generate(
                      5,
                      (index) => const Icon(
                        Icons.star,
                        size: 18,
                        color: Color(0xFFD1D5DB),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "৳1,100",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: colors.onSurfaceVariant,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(bottom: 2),
                            child: Text(
                              "৳",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "55",
                            style: TextStyle(
                              fontSize: 22,
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
