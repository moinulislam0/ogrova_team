import 'package:flutter/material.dart';
import 'package:ogrova_team/core/resource/constant/color_manager.dart';

const Color kPrimary = Color(0xFF00A86B);
const Color kPrimaryDark = Color(0xFF008C5A);
const Color kBg = Color(0xFFF1F5F9);
const Color kTextDark = Color(0xFF0F172A);
const Color kTextMuted = Color(0xFF64748B);

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool orderUpdates = true;
  bool promotions = true;
  bool securityAlerts = true;
  bool newsletter = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Notification",
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
          _switchTile(
            context,
            "Order Updates",
            "Get notified about order status",
            orderUpdates,
            (v) => setState(() => orderUpdates = v),
          ),
          _switchTile(
            context,
            "Promotions & Offers",
            "Special deals and discounts",
            promotions,
            (v) => setState(() => promotions = v),
          ),
          _switchTile(
            context,
            "Security Alerts",
            "Login & password change alerts",
            securityAlerts,
            (v) => setState(() => securityAlerts = v),
          ),
          _switchTile(
            context,
            "Newsletter",
            "Weekly product & news updates",
            newsletter,
            (v) => setState(() => newsletter = v),
          ),
        ],
      ),
    );
  }

  Widget _switchTile(
    BuildContext context,
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: ColorManager.settingsCardBorder(Theme.of(context).brightness),
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          _themeSwitch(context, value, onChanged),
        ],
      ),
    );
  }

  Widget _themeSwitch(
    BuildContext context,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      toggled: value,
      button: true,
      child: GestureDetector(
        onTap: () => onChanged(!value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 46,
          height: 27,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: value ? kPrimary.withValues(alpha: 0.45) : colors.surface,
            border: Border.all(
              color: value
                  ? kPrimary
                  : ColorManager.settingsCardBorder(
                      Theme.of(context).brightness,
                    ),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 180),
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 19,
              height: 19,
              decoration: BoxDecoration(
                color: value ? kPrimary : colors.onSurfaceVariant,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
