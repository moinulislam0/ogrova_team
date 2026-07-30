import 'package:flutter/material.dart';

const Color kPrimary = Color(0xFF00A86B);
const Color kPrimaryDark = Color(0xFF008C5A);
const Color kBg = Color(0xFFF1F5F9);
const Color kTextDark = Color(0xFF0F172A);
const Color kTextMuted = Color(0xFF64748B);

class PremiumPersonalInfoForm extends StatelessWidget {
  
  const PremiumPersonalInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
         
          _buildField(
            label: "Full Name",
            hintText: "Enter your full name",
            value: "Admin One",
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 16),

          // Phone Number
          _buildField(
            label: "Phone Number",
            hintText: "e.g. 017XXXXXXXX",
            value: "01711111112",
            icon: Icons.phone_outlined,
          ),
          const SizedBox(height: 16),

          // Email Address
          _buildField(
            label: "Email Address",
            hintText: "Enter your email address",
            value:
                "admin1@gmail.com", 
            icon: Icons.email_outlined,
          ),
          const SizedBox(height: 16),

          // Gender & Blood Group Row
          Row(
            children: [
              Expanded(
                child: _buildDropdownField("Gender", [
                  "Select",
                  "Male",
                  "Female",
                ]),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdownField("Blood Group", [
                  "Select",
                  "A+",
                  "B+",
                  "O+",
                  "AB+",
                  "A-",
                  "B-",
                  "O-",
                  "AB-",
                ]),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Present Address
          _buildField(
            label: "Present Address",
            hintText: "House, Road, Area details...",
            value: "Level 5, Business Center, Banani",
            icon: Icons.location_on_outlined,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  
  Widget _buildField({
    required String label,
    required String hintText,
    required String value,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF475569),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: value,
          maxLines: maxLines,
          style: const TextStyle(
            fontSize: 14,
            color: kTextDark,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hintText, 
            hintStyle: const TextStyle(
              color: Color(0xFF94A3B8),
              fontWeight: FontWeight.normal,
            ),
            prefixIcon: Icon(icon, color: const Color(0xFF94A3B8), size: 20),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
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
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
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

  Widget _buildDropdownField(String label, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF475569),
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: items.first,
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(fontSize: 14)),
                ),
              )
              .toList(),
          onChanged: (val) {},
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF94A3B8),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
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
