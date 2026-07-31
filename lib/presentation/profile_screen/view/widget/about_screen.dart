import 'package:flutter/material.dart';

const Color kPrimary = Color(0xFF00A86B);
const Color kPrimaryDark = Color(0xFF008C5A);
const Color kBg = Color(0xFFF1F5F9);
const Color kTextDark = Color(0xFF0F172A);
const Color kTextMuted = Color(0xFF64748B);

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "About",
          style: TextStyle(fontWeight: FontWeight.w700, color: colors.onSurface),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: colors.onSurface,
        iconTheme: IconThemeData(color: colors.onSurface),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
              padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border.all(color: colors.outlineVariant),
                borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: kPrimary.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shopping_bag_rounded,
                    color: kPrimary,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "OGROVA",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                    color: colors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Version 1.0.0",
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "OGROVA is your trusted online shopping destination. We deliver quality products with fast shipping and excellent customer support across Bangladesh.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 12),
                _aboutRow(context, "Website", "https://ogrova.mercuviax.com/"),
                _aboutRow(context, "Support", "support@ogrova.com"),
                _aboutRow(context, "Phone", "+880 1712-345678"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _aboutRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
