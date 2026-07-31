import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  final IconData? icon;
  final IconData? arrowIcon;
  final String? title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Color? iconBg;
  final Color? iconColor;

  const MenuTile({
    super.key,
    this.icon,
    this.arrowIcon,
    this.title,
    this.subtitle,
    this.onTap,
    this.iconBg = const Color(0xFFF1F5F9),
    this.iconColor = const Color(0xFF475569),
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconBg ?? colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor ?? colors.onSurfaceVariant, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: colors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle ?? "",
                      style: TextStyle(
                        fontSize: 11,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                arrowIcon,
                size: 14,
                color: colors.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
