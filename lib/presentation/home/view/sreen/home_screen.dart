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
      backgroundColor: Colors.transparent,
      drawer: const Drawer(),
      appBar: const OgrovaAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const OgrovaSearchBar(),
            const HomeBanner(),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  const CategoryItem(
                    title: "All",
                    image: "assets/images/all_category.png",
                  ),

                  if (categoryState.isLoading)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  else
                    ...categories.map((category) {
                      return CategoryItem(
                        title: category.name ?? "",
                        image: category.image ?? "",
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
