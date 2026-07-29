import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ogrova_team/presentation/add_to-cart/view/screen/add_to_cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;
  int selectedVariantIndex = 0;
  List<XFile> selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  final List<Map<String, dynamic>> variants = [
    {
      "title": "L | RED",
      "price": 399.0,
      "oldPrice": 884.0,
      "left": "6 Left",
      "color": Colors.red,
    },
    {
      "title": "S | BLACK",
      "price": 450.0,
      "oldPrice": 950.0,
      "left": "13 Left",
      "color": Colors.black,
    },
    {
      "title": "M | BLUE",
      "price": 420.0,
      "oldPrice": 900.0,
      "left": "5 Left",
      "color": Colors.blue,
    },
  ];

  Future<void> pickImages() async {
    if (selectedImages.length >= 4) return;
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        selectedImages.addAll(images);
        if (selectedImages.length > 4) {
          selectedImages = selectedImages.sublist(0, 4);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double currentBasePrice = variants[selectedVariantIndex]['price'];
    double currentOldPrice = variants[selectedVariantIndex]['oldPrice'];
    double totalPrice = currentBasePrice * quantity;
    double totalOldPrice = currentOldPrice * quantity;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BreadcrumbWidget(),
            const SizedBox(height: 15),
            const StockAndSkuWidget(),
            const SizedBox(height: 20),
            // ProductImageSection(image: ImageManager.logo), // ImageManager ইউজ করুন
            const ProductImageSection(),
            const SizedBox(height: 20),
            const BrandAndBadges(),
            const SizedBox(height: 10),
            const Text(
              "Sample Product 265",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "This is a summary of Sample Product 265",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            PriceBoxWidget(currentPrice: totalPrice, oldPrice: totalOldPrice),

            const SizedBox(height: 25),
            const Text(
              "CONFIGURE VARIANT",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 12),

            // ডাইনামিক ভেরিয়েন্ট লিস্ট
            Column(
              children: List.generate(variants.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedVariantIndex = index;
                    });
                  },
                  child: VariantCard(
                    title: variants[index]['title'],
                    price: "৳${variants[index]['price']}",
                    left: variants[index]['left'],
                    color: variants[index]['color'],
                    isSelected: selectedVariantIndex == index,
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),
            const DeliveryInfoWidget(),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QuantityButton(
                  icon: Icons.remove,
                  onTap: () {
                    if (quantity > 1) {
                      setState(() => quantity--);
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "$quantity",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                QuantityButton(
                  icon: Icons.add,
                  onTap: () => setState(() => quantity++),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ActionButton(
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
                );
              },
              label: "ADD TO CART",
              icon: Icons.shopping_bag_outlined,
              isPrimary: false,
            ),
            const SizedBox(height: 10),
            ActionButton(
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
                );
              },
              label: "BUY NOW",
              icon: Icons.flash_on,
              isPrimary: true,
            ),
          ],
        ),
      ),
    );
  }
}

class PriceBoxWidget extends StatelessWidget {
  final double currentPrice;
  final double oldPrice;

  const PriceBoxWidget({
    super.key,
    required this.currentPrice,
    required this.oldPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "TOTAL PRICE", // মার্কেট প্রাইস থেকে টোটাল প্রাইস নাম দিলাম
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "৳${currentPrice.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00A86B),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      "৳${oldPrice.toStringAsFixed(0)}",
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "Save ৳${(oldPrice - currentPrice).toStringAsFixed(0)}",
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Icon(Icons.sell_outlined, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

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

class StockAndSkuWidget extends StatelessWidget {
  const StockAndSkuWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            children: [
              Icon(Icons.circle, size: 8, color: Colors.green),
              SizedBox(width: 6),
              Text(
                "In Stock",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 15),
        const Text(
          "SKU: PRD-SKU-48SLA5",
          style: TextStyle(color: Colors.blueGrey, fontSize: 12),
        ),
      ],
    );
  }
}

class ProductImageSection extends StatelessWidget {
  const ProductImageSection({super.key});
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
            child: const Icon(Icons.image, size: 100, color: Colors.grey),
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

class VariantCard extends StatelessWidget {
  final String title, price, left;
  final Color color;
  final bool isSelected;
  const VariantCard({
    super.key,
    required this.title,
    required this.price,
    required this.left,
    required this.color,
    required this.isSelected,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFE8F5E9) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected ? const Color(0xFF00A86B) : Colors.grey.shade200,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, color: color, size: 18),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xFF00A86B),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            left,
            style: const TextStyle(
              color: Colors.green,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback ontap;
  const ActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.ontap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFF00A86B) : const Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFF00A86B)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isPrimary ? Colors.white : const Color(0xFF00A86B),
              size: 22,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: isPrimary ? Colors.white : const Color(0xFF00A86B),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomReviewField extends StatelessWidget {
  final String label, hintText;
  final int maxLines;
  const CustomReviewField({
    super.key,
    required this.label,
    required this.hintText,
    this.maxLines = 1,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
          ),
        ),
      ],
    );
  }
}

class BrandAndBadges extends StatelessWidget {
  const BrandAndBadges({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "H & M",
          style: TextStyle(
            color: Color(0xFF00A86B),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          "ELECTRONICS",
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const Spacer(),
        _badge("-55% OFF"),
        const SizedBox(width: 8),
        _badge("SALE", icon: Icons.local_fire_department),
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

class QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const QuantityButton({super.key, required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, size: 22, color: Colors.black54),
      ),
    );
  }
}

class DeliveryInfoWidget extends StatelessWidget {
  const DeliveryInfoWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9).withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            backgroundColor: Color(0xFF00A86B),
            child: Icon(Icons.flash_on, color: Colors.white, size: 20),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "EXPRESS DELIVERY AVAILABLE",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF00A86B),
                  ),
                ),
                Text(
                  "Order within 02h 45m to receive your package by tomorrow.",
                  style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
