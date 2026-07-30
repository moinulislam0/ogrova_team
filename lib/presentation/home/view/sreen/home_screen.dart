import 'package:flutter/material.dart';
import 'package:ogrova_team/core/resource/constant/color_manager.dart';
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
      backgroundColor: ColorManager.primary,
      drawer: Drawer(),
      appBar: OgrovaAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorManager.primary,
              Color(0xFFF0FDF6),
              Color(0xFFF8FAFC),
              Color(0xFFF1F5F9),
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: SingleChildScrollView(
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
                    CategoryItem(
                      title: "home",
                      icon: Icons.ice_skating_outlined,
                    ),
                    CategoryItem(
                      title: "home",
                      icon: Icons.ice_skating_outlined,
                    ),
                    CategoryItem(
                      title: "home",
                      icon: Icons.ice_skating_outlined,
                    ),
                    CategoryItem(
                      title: "home",
                      icon: Icons.ice_skating_outlined,
                    ),
                    CategoryItem(
                      title: "home",
                      icon: Icons.ice_skating_outlined,
                    ),
                  ],
                ),
              ),
              const SectionHeader(title: "FEATURED PRODUCTS"),
              const ProductGridView(),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
