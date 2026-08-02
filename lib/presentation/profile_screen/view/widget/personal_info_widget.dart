import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod ইম্পোর্ট করা হয়েছে
import 'package:ogrova_team/presentation/profile_screen/viewModel/order_details_provider.dart';

const Color kPrimary = Color(0xFF00A86B);
const Color kPrimaryDark = Color(0xFF008C5A);

class PremiumPersonalInfoForm extends ConsumerStatefulWidget {
  const PremiumPersonalInfoForm({super.key});

  @override
  ConsumerState<PremiumPersonalInfoForm> createState() =>
      _PremiumPersonalInfoFormState();
}

class _PremiumPersonalInfoFormState
    extends ConsumerState<PremiumPersonalInfoForm> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController addressController;

  String? selectedGender;
  String? selectedBloodGroup;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderDetailsProvider);
    final user = state.data?.data?.data?.firstOrNull?.user;

    if (user != null && nameController.text.isEmpty) {
      nameController.text = user.name ?? "";
      phoneController.text = user.phone ?? "";
      emailController.text = user.email ?? "";
      addressController.text = user.presentAddress ?? "";
      selectedGender = user.gender;
      selectedBloodGroup = user.bloodGroup;
    }

    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
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
          _buildField(
            context,
            label: "Full Name",
            hintText: "Enter your full name",
            controller: nameController,
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 16),

          // Phone Number
          _buildField(
            context,
            label: "Phone Number",
            hintText: "e.g. 017XXXXXXXX",
            controller: phoneController,
            icon: Icons.phone_outlined,
          ),
          const SizedBox(height: 16),

          // Email Address
          _buildField(
            context,
            label: "Email Address",
            hintText: "Enter your email address",
            controller: emailController,
            icon: Icons.email_outlined,
          ),
          const SizedBox(height: 16),

          // Gender & Blood Group Row
          Row(
            children: [
              Expanded(
                child: _buildDropdownField(
                  context,
                  "Gender",
                  ["Select", "Male", "Female"],
                  currentValue: selectedGender,
                  onChanged: (val) => setState(() => selectedGender = val),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdownField(
                  context,
                  "Blood Group",
                  ["Select", "A+", "B+", "O+", "AB+", "A-", "B-", "O-", "AB-"],
                  currentValue: selectedBloodGroup,
                  onChanged: (val) => setState(() => selectedBloodGroup = val),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Present Address
          _buildField(
            context,
            label: "Present Address",
            hintText: "House, Road, Area details...",
            controller: addressController,
            icon: Icons.location_on_outlined,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildField(
    BuildContext context, {
    required String label,
    required String hintText,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
  }) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: colors.onSurface,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: 14,
            color: colors.onSurface,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.normal,
            ),
            prefixIcon: Icon(icon, color: colors.onSurfaceVariant, size: 20),
            filled: true,
            fillColor: colors.surfaceContainerHighest,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colors.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: kPrimary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(
    BuildContext context,
    String label,
    List<String> items, {
    String? currentValue,
    required Function(String?) onChanged,
  }) {
    final colors = Theme.of(context).colorScheme;

    String? effectiveValue = items.contains(currentValue)
        ? currentValue
        : items.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: colors.onSurface,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: effectiveValue,
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: TextStyle(fontSize: 14, color: colors.onSurface),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: colors.onSurfaceVariant,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: colors.surfaceContainerHighest,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colors.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: kPrimary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
