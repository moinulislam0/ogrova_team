import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ogrova_team/presentation/auth/login_screen/view/login_screen.dart';
import 'package:ogrova_team/presentation/home/view/widget/section_header.dart';
import 'package:ogrova_team/presentation/profile_screen/view/widget/about_screen.dart';
import 'package:ogrova_team/presentation/profile_screen/view/widget/header_widget.dart';
import 'package:ogrova_team/presentation/profile_screen/view/widget/menu_tile_widget.dart';
import 'package:ogrova_team/presentation/profile_screen/view/widget/notification_widget.dart';
import 'package:ogrova_team/presentation/profile_screen/view/widget/order_history_widget.dart';
import 'package:ogrova_team/presentation/profile_screen/view/widget/personal_info_widget.dart';
import 'package:ogrova_team/presentation/profile_screen/view/widget/privacy_widget.dart';
import 'package:ogrova_team/presentation/profile_screen/view/widget/security_widget.dart';
import 'package:ogrova_team/presentation/profile_screen/view/widget/star_card_widget.dart';
import 'package:ogrova_team/presentation/profile_screen/view/widget/theme_widget.dart';

// ==================== PRIMARY COLOR ====================
const Color kPrimary = Color(0xFF00A86B);
const Color kPrimaryDark = Color(0xFF008C5A);
const Color kBg = Color(0xFFF1F5F9);
const Color kTextDark = Color(0xFF0F172A);
const Color kTextMuted = Color(0xFF64748B);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          "My Profile",
          style: TextStyle(
            color: kTextDark,
            fontWeight: FontWeight.w800,
            fontSize: 20,
            letterSpacing: -0.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.refresh_rounded, color: Color(0xFF475569)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            const PremiumProfileHeader(),
            const SizedBox(height: 24),

            // Stats
            const Row(
              children: [
                Expanded(
                  child: PremiumStatCard(
                    label: "Orders",
                    value: "2",
                    icon: Icons.shopping_bag_outlined,
                    gradientColors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: PremiumStatCard(
                    label: "Reviews",
                    value: "0",
                    icon: Icons.star_outline_rounded,
                    gradientColors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: PremiumStatCard(
                    label: "Points",
                    value: "120",
                    icon: Icons.workspace_premium_outlined,
                    gradientColors: [kPrimary, kPrimaryDark],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Manage Account
            const SectionHeader(title: "MANAGE ACCOUNT"),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF64748B).withOpacity(0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  MenuTile(
                    arrowIcon: Icons.arrow_forward_ios_rounded,
                    icon: Icons.shopping_bag_outlined,
                    title: "Orders",
                    subtitle: "Manage and track orders",
                    iconBg: kPrimary.withOpacity(0.12),
                    iconColor: kPrimary,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OrderHistoryScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDivider(),
                  MenuTile(
                    arrowIcon: Icons.arrow_forward_ios_rounded,
                    icon: Icons.palette_outlined,
                    title: "Theme",
                    subtitle: "Light / Dark mode",
                    iconBg: const Color(0xFFF1F5F9),
                    iconColor: const Color(0xFF475569),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ThemeScreen()),
                      );
                    },
                  ),
                  _buildDivider(),
                  MenuTile(
                    arrowIcon: Icons.arrow_forward_ios_rounded,
                    icon: Icons.notifications_none_rounded,
                    title: "Notification",
                    subtitle: "Alerts & updates",
                    iconBg: const Color(0xFFF1F5F9),
                    iconColor: const Color(0xFF475569),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDivider(),
                  MenuTile(
                    arrowIcon: Icons.arrow_forward_ios_rounded,
                    icon: Icons.shield_outlined,
                    title: "Security",
                    subtitle: "Password & protection",
                    iconBg: const Color(0xFFF1F5F9),
                    iconColor: const Color(0xFF475569),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SecurityScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDivider(),
                  MenuTile(
                    arrowIcon: Icons.arrow_forward_ios_rounded,
                    icon: Icons.privacy_tip_outlined,
                    title: "Privacy & Policy",
                    subtitle: "Data & privacy rules",
                    iconBg: const Color(0xFFF1F5F9),
                    iconColor: const Color(0xFF475569),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDivider(),
                  MenuTile(
                    arrowIcon: Icons.arrow_forward_ios_rounded,
                    icon: Icons.info_outline_rounded,
                    title: "About",
                    subtitle: "Learn more about us",
                    iconBg: const Color(0xFFF1F5F9),
                    iconColor: const Color(0xFF475569),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AboutScreen()),
                      );
                    },
                  ),
                  _buildDivider(),
                  MenuTile(
                    icon: Icons.logout,
                    title: "LogOut",
                    iconBg: CupertinoColors.destructiveRed,
                    iconColor: const Color(0xFF475569),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Personal Info
            const SectionHeader(title: "PERSONAL INFORMATION"),
            const SizedBox(height: 12),
            const PremiumPersonalInfoForm(),

            const SizedBox(height: 32),

            // Save Button
            Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [kPrimary, kPrimaryDark],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: kPrimary.withOpacity(0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                ),
                label: const Text(
                  "SAVE CHANGES",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9));
  }
}
