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
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        title: const Text(
          "Security",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: kTextDark,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _secTile(
            Icons.lock_outline_rounded,
            "Change Password",
            "Update your account password",
            () {},
          ),
          _secTile(
            Icons.phonelink_lock_rounded,
            "Two-Factor Authentication",
            "Add extra security layer",
            () {},
          ),
          _secTile(
            Icons.devices_rounded,
            "Active Sessions",
            "Manage logged-in devices",
            () {},
          ),
          _secTile(
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
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
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
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: kTextMuted),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: Color(0xFFCBD5E1),
        ),
      ),
    );
  }
}