import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrova_team/presentation/home/view/widget/product_card.dart';
import 'package:ogrova_team/presentation/home/viewModel/get_categories_provider.dart';
import 'package:ogrova_team/presentation/home/viewModel/public_products_provider.dart';

class ProductGridView extends ConsumerWidget {
  const ProductGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final publicProductState = ref.watch(publicProducts);
    final categoryProductState = ref.watch(getProductsProvider);

 
    final bool isCategoryFiltered = categoryProductState.categoryProducts != null;

    final bool isLoading = isCategoryFiltered 
        ? categoryProductState.isLoading 
        : publicProductState.isLoading;

    final String? errorMessage = isCategoryFiltered 
        ? categoryProductState.errorMessage 
        : publicProductState.errorMessage;

   
    final productList = isCategoryFiltered
        ? (categoryProductState.categoryProducts?.products?.data ?? [])
        : (publicProductState.data?.data?.data ?? []);

    if (isLoading) {
      return const SizedBox(
        height: 250,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage, style: const TextStyle(color: Colors.red)));
    }

    if (productList.isEmpty) {
      return const SizedBox(
        height: 150,
        child: Center(child: Text("No products found in this category")),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.65,
      ),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return ProductCard(product: productList[index]);
      },
    );
  }
}