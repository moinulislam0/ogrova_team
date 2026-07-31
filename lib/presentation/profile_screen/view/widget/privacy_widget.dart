import 'package:flutter/material.dart';

const Color kPrimary = Color(0xFF00A86B);
const Color kPrimaryDark = Color(0xFF008C5A);
const Color kBg = Color(0xFFF1F5F9);
const Color kTextDark = Color(0xFF0F172A);
const Color kTextMuted = Color(0xFF64748B);

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Privacy & Policy",
          style: TextStyle(fontWeight: FontWeight.w700, color: colors.onSurface),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: colors.onSurface,
        iconTheme: IconThemeData(color: colors.onSurface),
      ),
      body: ListView(
              padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border.all(color: colors.outlineVariant),
                borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Privacy Policy",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: colors.onSurface,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "We collect only the data necessary to provide our services. Your personal information is never sold to third parties.\n\n"
                  "• Order & delivery data is stored securely\n"
                  "• Payment information is processed by trusted gateways\n"
                  "• You can request data deletion anytime\n"
                  "• Cookies are used only for better experience\n\n"
                  "For full details, contact support@ogrova.com",
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
