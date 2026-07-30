import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ogrova_team/presentation/add_to-cart/view/screen/add_to_cart_screen.dart';
import 'package:ogrova_team/presentation/products_details/view/widget/action_button_widget.dart';
import 'package:ogrova_team/presentation/products_details/view/widget/brand_badge_widget.dart';
import 'package:ogrova_team/presentation/products_details/view/widget/delivery_info_widget.dart';
import 'package:ogrova_team/presentation/products_details/view/widget/price_box_widget.dart';
import 'package:ogrova_team/presentation/products_details/view/widget/product_image_widget.dart';
import 'package:ogrova_team/presentation/products_details/view/widget/quantity_widget.dart';
import 'package:ogrova_team/presentation/products_details/view/widget/stuck_widget.dart';
import 'package:ogrova_team/presentation/products_details/view/widget/variant_card_widget.dart';

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
        backgroundColor: Colors.transparent,
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
            // const BreadcrumbWidget(),
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
