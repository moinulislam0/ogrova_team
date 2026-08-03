import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrova_team/presentation/home/view/widget/app_bar_widget.dart';
import 'package:ogrova_team/presentation/home/view/widget/categorie_item.dart';
import 'package:ogrova_team/presentation/home/view/widget/home_banner.dart';
import 'package:ogrova_team/presentation/home/view/widget/product_grid_view.dart';
import 'package:ogrova_team/presentation/home/view/widget/search_bar.dart';
import 'package:ogrova_team/presentation/home/view/widget/section_header.dart';
import 'package:ogrova_team/presentation/home/viewModel/get_categories_provider.dart';
import 'package:ogrova_team/presentation/home/viewModel/public_products_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(publicProducts.notifier).getPublicProducts(); 
      ref.read(getProductsProvider.notifier).getPublicProducts(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(getProductsProvider);
    final categories = categoryState.data?.data ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const Drawer(),
      appBar: const OgrovaAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const OgrovaSearchBar(),
            const HomeBanner(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  CategoryItem(
                    id: 0,
                    title: "All",
                    ontap: () {
                      // এটি কল করলে ফিল্টার ক্লিয়ার হবে এবং সব প্রোডাক্ট শো করবে
                      ref.read(getProductsProvider.notifier).clearCategoryProducts();
                      ref.read(publicProducts.notifier).getPublicProducts();
                    },
                  ),
                  if (categoryState.isLoading && categories.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: CircularProgressIndicator(),
                    )
                  else
                    ...categories.map((category) {
                      return CategoryItem(
                        id: category.id ?? 0,
                        title: category.name ?? "",
                        ontap: () {
                          ref.read(getProductsProvider.notifier).getProductsByCategory(category.id!);
                        },
                      );
                    }).toList(),
                ],
              ),
            ),
            const SectionHeader(title: "FEATURED PRODUCTS"),
            const ProductGridView(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}