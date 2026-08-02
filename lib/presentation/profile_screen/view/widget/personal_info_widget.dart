import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrova_team/presentation/profile_screen/viewModel/order_details_provider.dart';

const Color kPrimary = Color(0xFF00A86B);

final profileFormControllerProvider = Provider(
  (ref) => ProfileFormControllers(),
);

class ProfileFormControllers {
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final presentAddress = TextEditingController();
  final permanentAddress = TextEditingController();
  final nationalId = TextEditingController();
  String? gender;
  String? bloodGroup;

  void dispose() {
    name.dispose();
    phone.dispose();
    email.dispose();
    presentAddress.dispose();
    permanentAddress.dispose();
    nationalId.dispose();
  }
}

class PremiumPersonalInfoForm extends ConsumerStatefulWidget {
  const PremiumPersonalInfoForm({super.key});

  @override
  ConsumerState<PremiumPersonalInfoForm> createState() =>
      _PremiumPersonalInfoFormState();
}

class _PremiumPersonalInfoFormState
    extends ConsumerState<PremiumPersonalInfoForm> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderDetailsProvider);
    final user = state.data?.data?.data?.firstOrNull?.user;
    final controllers = ref.watch(profileFormControllerProvider);

    // Initial value setup
    if (user != null && controllers.name.text.isEmpty) {
      controllers.name.text = user.name ?? "";
      controllers.phone.text = user.phone ?? "";
      controllers.email.text = user.email ?? "";
      controllers.presentAddress.text = user.presentAddress ?? "";
      controllers.permanentAddress.text = user.permanentAddress ?? "";
      controllers.nationalId.text = user.nationalId ?? "";
      controllers.gender = user.gender;
      controllers.bloodGroup = user.bloodGroup;
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
            controller: controllers.name,
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 16),
          _buildField(
            context,
            label: "Phone Number",
            hintText: "e.g. 017XXXXXXXX",
            controller: controllers.phone,
            icon: Icons.phone_outlined,
          ),
          const SizedBox(height: 16),

          _buildField(
            context,
            label: "Email Address",
            hintText: "Enter your email address",
            controller: controllers.email,
            icon: Icons.email_outlined,
            readOnly: true,
          ),

          const SizedBox(height: 16),
          _buildField(
            context,
            label: "National ID (NID)",
            hintText: "Enter your NID number",
            controller: controllers.nationalId,
            icon: Icons.badge_outlined,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDropdownField(
                  context,
                  "Gender",
                  ["Select", "Male", "Female"],
                  currentValue: controllers.gender,
                  onChanged: (val) {
                    setState(() {
                      controllers.gender = val;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdownField(
                  context,
                  "Blood Group",
                  ["Select", "A+", "B+", "O+", "AB+", "A-", "B-", "O-", "AB-"],
                  currentValue: controllers.bloodGroup,
                  onChanged: (val) =>
                      setState(() => controllers.bloodGroup = val),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildField(
            context,
            label: "Present Address",
            hintText: "House, Road, Area details...",
            controller: controllers.presentAddress,
            icon: Icons.location_on_outlined,
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          _buildField(
            context,
            label: "Permanent Address",
            hintText: "Enter permanent address",
            controller: controllers.permanentAddress,
            icon: Icons.home_outlined,
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
    bool readOnly = false,
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
          readOnly: readOnly,
          style: TextStyle(
            fontSize: 14,
            color: readOnly
                ? colors.onSurface.withOpacity(0.5)
                : colors.onSurface,
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
              borderSide: BorderSide(color: Colors.grey),
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
              borderSide: BorderSide(color: Colors.grey),
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
