import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrova_team/core/resource/constant/image_manager.dart';
import 'package:ogrova_team/core/resource/theme_provider.dart';

class OgrovaAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const OgrovaAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = Theme.of(context).brightness;
    final iconColor = Theme.of(context).colorScheme.onSurface;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
          icon: Icon(Icons.notifications_none_rounded, color: Colors.black),
        ),
        IconButton(
          tooltip: brightness == Brightness.dark
              ? 'Switch to light theme'
              : 'Switch to dark theme',
          onPressed: () {
            ref
                .read(themeModeProvider.notifier)
                .state = brightness == Brightness.dark
                ? ThemeMode.light
                : ThemeMode.dark;
          },
          icon: Icon(
            brightness == Brightness.dark
                ? Icons.dark_mode_outlined
                : Icons.wb_sunny_outlined,
            color: iconColor,
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
