import 'package:flutter/material.dart';
import 'package:ogrova_team/presentation/home/view/widget/app_bar_widget.dart';
import 'package:ogrova_team/presentation/home/view/widget/categorie_item.dart';
import 'package:ogrova_team/presentation/home/view/widget/home_banner.dart';
import 'package:ogrova_team/presentation/home/view/widget/product_grid_view.dart';
import 'package:ogrova_team/presentation/home/view/widget/search_bar.dart';
import 'package:ogrova_team/presentation/home/view/widget/section_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      drawer: Drawer(),
      appBar: OgrovaAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            OgrovaSearchBar(),
            HomeBanner(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
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
