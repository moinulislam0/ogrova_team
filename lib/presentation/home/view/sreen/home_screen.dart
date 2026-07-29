import 'package:flutter/material.dart';
import 'package:ogrova_team/presentation/home/view/widget/app_bar_widget.dart';
import 'package:ogrova_team/presentation/home/view/widget/home_banner.dart';
import 'package:ogrova_team/presentation/home/view/widget/product_grid_view.dart';
import 'package:ogrova_team/presentation/home/view/widget/search_bar.dart';
import 'package:ogrova_team/presentation/home/view/widget/section_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),

      appBar: OgrovaAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            OgrovaSearchBar(),
            HomeBanner(),
            const SectionHeader(title: "FEATURED PRODUCTS"),
            const ProductGridView(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
