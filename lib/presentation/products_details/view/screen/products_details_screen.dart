import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrova_team/core/resource/constant/image_manager.dart';
import 'package:ogrova_team/data/sources/local/shared_preference/shared_prefenrence.dart';
import 'package:ogrova_team/presentation/auth/login_screen/view/login_screen.dart';
import 'package:ogrova_team/presentation/main_screen/view/screen/main_screen.dart';
import 'package:ogrova_team/presentation/products_details/view/widget/action_button_widget.dart';
import 'package:ogrova_team/presentation/products_details/view/widget/brand_badge_widget.dart';
import 'package:ogrova_team/presentation/products_details/view/widget/delivery_info_widget.dart';
import 'package:ogrova_team/presentation/products_details/view/widget/price_box_widget.dart';
import 'package:ogrova_team/presentation/products_details/view/widget/product_image_widget.dart';
import 'package:ogrova_team/presentation/products_details/view/widget/quantity_widget.dart';
import 'package:ogrova_team/presentation/products_details/view/widget/stuck_widget.dart';
import 'package:ogrova_team/presentation/products_details/view/widget/variant_card_widget.dart';
import 'package:ogrova_team/presentation/products_details/viewModel/add_to_card_provider.dart';
import 'package:ogrova_team/presentation/products_details/viewModel/products_details_provider.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final String slug;
  const ProductDetailsScreen({super.key, required this.slug});

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  int quantity = 1;
  int selectedVariantIndex = 0;
  int activeImageIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productDetailsProvider.notifier).getdata(widget.slug);
    });
  }

  Future<void> _handleAddToCart() async {
    final token = await SharedPreferenceData.getToken();

    if (token == null || token.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please login to add items to cart!")),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
      return;
    }

    final product = ref.read(productDetailsProvider).data?.data;
    if (product == null) return;

    final int productId = product.id ?? 0;

    final int variantId =
        (product.variants != null && product.variants!.isNotEmpty)
        ? (product.variants![selectedVariantIndex].id ?? 0)
        : 0;

    final success = await ref
        .read(addToCardProvider.notifier)
        .addToCart(
          productId: productId,
          variantId: variantId,
          quantity: quantity,
        );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Added to cart successfully!")),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen(initialIndex: 1)),
      );
    } else if (mounted) {
      final error = ref.read(addToCardProvider).errorMessage;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error ?? "Failed to add to cart")));
    }
  }

  Future<void> _handleBuyNow() async {
    final token = await SharedPreferenceData.getToken();

    if (!mounted) return;

    if (token == null || token.trim().isEmpty) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
      return;
    }

    final product = ref.read(productDetailsProvider).data?.data;
    if (product == null) return;

    final productId = product.id ?? 0;
    final variantId = product.variants != null && product.variants!.isNotEmpty
        ? (product.variants![selectedVariantIndex].id ?? 0)
        : 0;

    final added = await ref
        .read(addToCardProvider.notifier)
        .addToCart(
          productId: productId,
          variantId: variantId,
          quantity: quantity,
        );

    if (!mounted) return;
    if (!added) {
      final error = ref.read(addToCardProvider).errorMessage;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? 'Unable to add this item to your cart.'),
        ),
      );
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(initialIndex: 1),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productDetailsProvider);

    if (state.isloading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.errormessage != null) {
      return Scaffold(
        body: Center(child: Text("Error: ${state.errormessage}")),
      );
    }

    final product = state.data?.data;
    if (product == null) {
      return const Scaffold(body: Center(child: Text("No product found")));
    }

    double currentBasePrice = double.tryParse(product.price ?? "0") ?? 0.0;
    double currentOldPrice =
        currentBasePrice + (double.tryParse(product.discount ?? "0") ?? 0.0);

    if (product.variants != null && product.variants!.isNotEmpty) {
      currentBasePrice =
          double.tryParse(
            product.variants![selectedVariantIndex].price ?? "0",
          ) ??
          currentBasePrice;
    }

    double totalPrice = currentBasePrice * quantity;
    double totalOldPrice = currentOldPrice * quantity;

    List<dynamic> images = product.images != null && product.images!.isNotEmpty
        ? product.images!
        : [ImageManager.products];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.share_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            StockAndSkuWidget(
              sku: product.sku ?? "N/A",
              isInStock: product.stockQuantity.toString(),
            ),
            const SizedBox(height: 20),
            ProductImageSection(image: images[activeImageIndex].toString()),
            const SizedBox(height: 15),
            if (images.length > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (index) {
                  bool isSelected = activeImageIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => activeImageIndex = index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? Colors.green
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          images[index].toString(),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            const SizedBox(height: 20),
            BrandAndBadges(
              brandName: product.brand?.name ?? "No Brand",
              categoryName: product.category?.name ?? "General",
              discount: product.discount,
            ),
            const SizedBox(height: 10),
            Text(
              product.name ?? "Product Name",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              product.summary ?? "No summary available",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            PriceBoxWidget(currentPrice: totalPrice, oldPrice: totalOldPrice),
            const SizedBox(height: 25),
            if (product.variants != null && product.variants!.isNotEmpty) ...[
              const Text(
                "CONFIGURE VARIANT",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 12),
              Column(
                children: List.generate(product.variants!.length, (index) {
                  final v = product.variants![index];
                  return GestureDetector(
                    onTap: () => setState(() => selectedVariantIndex = index),
                    child: VariantCard(
                      title: "${v.size ?? ''} | ${v.color ?? ''}",
                      price: "৳${v.price}",
                      left: "${v.stockQuantity ?? 0} Left",
                      color: Colors.blue,
                      isSelected: selectedVariantIndex == index,
                    ),
                  );
                }),
              ),
            ],
            const SizedBox(height: 20),
            const DeliveryInfoWidget(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final cartState = ref.watch(addToCardProvider);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
                  if (quantity > 1) setState(() => quantity--);
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
              if (!cartState.isLoading) {
                _handleAddToCart();
              }
            },
            label: cartState.isLoading ? "ADDING..." : "ADD TO CART",
            icon: Icons.shopping_bag_outlined,
            isPrimary: false,
          ),
          const SizedBox(height: 10),
          ActionButton(
            ontap: () {
              if (!cartState.isLoading) {
                _handleBuyNow();
              }
            },
            label: cartState.isLoading ? "ADDING..." : "BUY NOW",
            icon: Icons.flash_on,
            isPrimary: true,
          ),
        ],
      ),
    );
  }
}
