import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrova_team/presentation/home/viewModel/get_categories_provider.dart';

class OgrovaSearchBar extends ConsumerWidget {
  const OgrovaSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: TextField(
        onChanged: (value) {
          final String query = value.toLowerCase().trim();

          if (query.isEmpty) {
            ref.read(getProductsProvider.notifier).clearCategoryProducts();
          } else {
            ref.read(getProductsProvider.notifier).searchProducts(query);
          }
        },
        decoration: InputDecoration(
          hintText: "Search for Ogrova...",
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
