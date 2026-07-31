import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrova_team/core/resource/constant/color_manager.dart';
import 'package:ogrova_team/core/resource/theme_provider.dart';

const Color kPrimary = Color(0xFF00A86B);
const Color kPrimaryDark = Color(0xFF008C5A);
const Color kBg = Color(0xFFF1F5F9);
const Color kTextDark = Color(0xFF0F172A);
const Color kTextMuted = Color(0xFF64748B);

class ThemeScreen extends ConsumerWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMode = ref.watch(themeModeProvider);
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Theme",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: colors.onSurface,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: colors.onSurface,
        iconTheme: IconThemeData(color: colors.onSurface),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _themeOption(
            context,
            ref,
            selectedMode,
            ThemeMode.system,
            "System",
            Icons.phone_android_rounded,
            "Follow device setting",
          ),
          _themeOption(
            context,
            ref,
            selectedMode,
            ThemeMode.light,
            "Light",
            Icons.light_mode_outlined,
            "Always light mode",
          ),
          _themeOption(
            context,
            ref,
            selectedMode,
            ThemeMode.dark,
            "Dark",
            Icons.dark_mode_outlined,
            "Always dark mode",
          ),
        ],
      ),
    );
  }

  Widget _themeOption(
    BuildContext context,
    WidgetRef ref,
    ThemeMode selectedMode,
    ThemeMode mode,
    String title,
    IconData icon,
    String subtitle,
  ) {
    final isSelected = selectedMode == mode;
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => ref.read(themeModeProvider.notifier).state = mode,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : ColorManager.settingsCardBorder(Theme.of(context).brightness),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.primary.withValues(alpha: 0.12)
                    : colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
