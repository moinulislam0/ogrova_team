import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrova_team/presentation/home/view/widget/product_card.dart';
import 'package:ogrova_team/presentation/home/viewModel/public_products_provider.dart'; 

class ProductGridView extends ConsumerWidget {
  const ProductGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final productState = ref.watch(publicProducts);
    
  
    if (productState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }


    if (productState.errorMessage != null) {
      return Center(child: Text(productState.errorMessage!));
    }


    final productList = productState.data?.data?.data ?? [];
    if (productList.isEmpty) {
      return const Center(child: Text("No products found"));
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
        final product = productList[index];
        return ProductCard(product: product); 
      },
    );
  }
}