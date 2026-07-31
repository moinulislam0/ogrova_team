import 'package:flutter/material.dart';

const Color kPrimary = Color(0xFF00A86B);
const Color kPrimaryDark = Color(0xFF008C5A);
const Color kBg = Color(0xFFF1F5F9);
const Color kTextDark = Color(0xFF0F172A);
const Color kTextMuted = Color(0xFF64748B);

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Security",
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
          _secTile(
            context,
            Icons.lock_outline_rounded,
            "Change Password",
            "Update your account password",
            () {},
          ),
          _secTile(
            context,
            Icons.phonelink_lock_rounded,
            "Two-Factor Authentication",
            "Add extra security layer",
            () {},
          ),
          _secTile(
            context,
            Icons.devices_rounded,
            "Active Sessions",
            "Manage logged-in devices",
            () {},
          ),
          _secTile(
            context,
            Icons.security_rounded,
            "Login Alerts",
            "Get notified of new logins",
            () {},
          ),
        ],
      ),
    );
  }

  Widget _secTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withOpacity(0.12)
              : Colors.grey.shade300,
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
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: kPrimary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: kPrimary),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    );
  }
}
