import 'package:flutter/material.dart';
import 'package:ogrova_team/core/resource/constant/image_manager.dart';

class OgrovaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OgrovaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0.5,

      leadingWidth: 150,

      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 100,

            height: 40,
            child: Image.asset(ImageManager.logo, fit: BoxFit.cover),
          ),
        ),
      ),

      // title: const Text(
      //   "OGROVA",
      //   style: TextStyle(
      //     color: Color(0xFF00A86B),
      //     fontWeight: FontWeight.bold,
      //     fontSize: 18,
      //   ),
      // ),
      centerTitle: true,

      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.wb_sunny_outlined, color: Colors.black),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
