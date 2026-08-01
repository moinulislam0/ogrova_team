import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrova_team/presentation/home/view/widget/app_bar_widget.dart';
import 'package:ogrova_team/presentation/home/view/widget/categorie_item.dart';
import 'package:ogrova_team/presentation/home/view/widget/home_banner.dart';
import 'package:ogrova_team/presentation/home/view/widget/product_grid_view.dart';
import 'package:ogrova_team/presentation/home/view/widget/search_bar.dart';
import 'package:ogrova_team/presentation/home/view/widget/section_header.dart';
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
    });
  }

  @override
  Widget build(BuildContext context) {
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
              child: Row(
                children: const [
                  CategoryItem(title: "All", icon: Icons.all_inbox),
                  CategoryItem(title: "Shoe", icon: Icons.label),
                  CategoryItem(title: "home", icon: Icons.ice_skating_outlined),
                  CategoryItem(title: "home", icon: Icons.ice_skating_outlined),
                  CategoryItem(title: "home", icon: Icons.ice_skating_outlined),
                  CategoryItem(title: "home", icon: Icons.ice_skating_outlined),
                  CategoryItem(title: "home", icon: Icons.ice_skating_outlined),
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