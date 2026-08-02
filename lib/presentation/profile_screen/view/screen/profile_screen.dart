import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/core/network/api_endpoints.dart';
import 'package:ogrova_team/data/sources/local/shared_preference/shared_prefenrence.dart';
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
import 'package:ogrova_team/presentation/profile_screen/viewModel/order_details_provider.dart';
import 'package:ogrova_team/presentation/profile_screen/viewModel/profile_update_provider.dart'; // Import update provider

const Color kPrimary = Color(0xFF00A86B);
const Color kPrimaryDark = Color(0xFF008C5A);

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(orderDetailsProvider.notifier).getdata());
  }

  Future<void> _logout() async {
    try {
      await ApiClient().postRequest(endpoints: ApiEndpoints.logout);
    } catch (_) {
    } finally {
      await SharedPreferenceData.removeToken();
      await ApiClient.headerSet();

      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }


  Future<void> _handleUpdate() async {
    final controllers = ref.read(profileFormControllerProvider);
    final updateNotifier = ref.read(profileUpdateProvider.notifier);
    final image = ref.read(selectedImageProvider);
    
    final success = await updateNotifier.profileUpdate(
      name: controllers.name.text,
      email: controllers.email.text,
      dob: "", 
      phone: controllers.phone.text,
      gender: controllers.gender ?? "",
      bloodGroup: controllers.bloodGroup ?? "",
      presentAddress: controllers.presentAddress.text,
      permanentAddress: controllers.permanentAddress.text,
      nationalId: controllers.nationalId.text,
      photo: image?.path ?? "",
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully!")),
      );
      ref.read(orderDetailsProvider.notifier).getdata(); // ডাটা রিফ্রেশ
    } else {
      final error = ref.read(profileUpdateProvider).errorMessage;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error ?? "Update failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderDetailsProvider);
    final updateState = ref.watch(profileUpdateProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "My Profile",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
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
              color: Theme.of(context).colorScheme.surface,
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
              onPressed: () => ref.read(orderDetailsProvider.notifier).getdata(),
              icon: Icon(
                Icons.refresh_rounded,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
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
            Row(
              children: [
                Expanded(
                  child: PremiumStatCard(
                    label: "Orders",
                    value: "${state.data?.data?.total ?? 0}",
                    icon: Icons.shopping_bag_outlined,
                    gradientColors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: PremiumStatCard(
                    label: "Reviews",
                    value: "0",
                    icon: Icons.star_outline_rounded,
                    gradientColors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PremiumStatCard(
                    label: "Points",
                    value: "${state.data?.data?.data?.firstOrNull?.point ?? 0}",
                    icon: Icons.workspace_premium_outlined,
                    gradientColors: [kPrimary, kPrimaryDark],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            const SectionHeader(title: "MANAGE ACCOUNT"),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
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
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderHistoryScreen()));
                    },
                  ),
                  _buildDivider(context),
                  MenuTile(
                    arrowIcon: Icons.arrow_forward_ios_rounded,
                    icon: Icons.palette_outlined,
                    title: "Theme",
                    subtitle: "Light / Dark mode",
                    iconBg: const Color(0xFFF1F5F9),
                    iconColor: const Color(0xFF475569),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ThemeScreen()));
                    },
                  ),
                  _buildDivider(context),
                  MenuTile(
                    arrowIcon: Icons.arrow_forward_ios_rounded,
                    icon: Icons.notifications_none_rounded,
                    title: "Notification",
                    subtitle: "Alerts & updates",
                    iconBg: const Color(0xFFF1F5F9),
                    iconColor: const Color(0xFF475569),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen()));
                    },
                  ),
                  _buildDivider(context),
                  MenuTile(
                    arrowIcon: Icons.arrow_forward_ios_rounded,
                    icon: Icons.shield_outlined,
                    title: "Security",
                    subtitle: "Password & protection",
                    iconBg: const Color(0xFFF1F5F9),
                    iconColor: const Color(0xFF475569),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SecurityScreen()));
                    },
                  ),
                  _buildDivider(context),
                  MenuTile(
                    arrowIcon: Icons.arrow_forward_ios_rounded,
                    icon: Icons.privacy_tip_outlined,
                    title: "Privacy & Policy",
                    subtitle: "Data & privacy rules",
                    iconBg: const Color(0xFFF1F5F9),
                    iconColor: const Color(0xFF475569),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()));
                    },
                  ),
                  _buildDivider(context),
                  MenuTile(
                    arrowIcon: Icons.arrow_forward_ios_rounded,
                    icon: Icons.info_outline_rounded,
                    title: "About",
                    subtitle: "Learn more about us",
                    iconBg: const Color(0xFFF1F5F9),
                    iconColor: const Color(0xFF475569),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen()));
                    },
                  ),
                  _buildDivider(context),
                  MenuTile(
                    icon: Icons.logout,
                    title: "LogOut",
                    iconBg: CupertinoColors.destructiveRed,
                    iconColor: Colors.white,
                    onTap: _logout,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const SectionHeader(title: "PERSONAL INFORMATION"),
            const SizedBox(height: 12),
            const PremiumPersonalInfoForm(),

            const SizedBox(height: 32),

            // Save Button Implementation
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
                onPressed: updateState.isLoading ? null : _handleUpdate,
                icon: updateState.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Icon(Icons.check_circle_outline, color: Colors.white),
                label: Text(
                  updateState.isLoading ? "UPDATING..." : "SAVE CHANGES",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(height: 1, thickness: 1, color: Theme.of(context).dividerColor);
  }
}