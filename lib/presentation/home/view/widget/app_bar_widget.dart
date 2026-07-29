import 'package:flutter/material.dart';

class OgrovaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OgrovaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0.5,
      title: const Text(
        "OGROVA",
        style: TextStyle(color: Color(0xFF00A86B), fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart, color: Colors.black),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
