import 'package:flutter/material.dart';

class RegistrationTextField extends StatelessWidget {
  final String label, hint;
  final TextEditingController? controller;
  final IconData? icon;
  final int lines;
  final bool readOnly, isPassword, obscureText;
  final VoidCallback? onTap, onTogglePassword;
  final TextInputType keyboardType;

  const RegistrationTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.icon,
    this.lines = 1,
    this.readOnly = false,
    this.isPassword = false,
    this.obscureText = false,
    this.onTap,
    this.onTogglePassword,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            maxLines: isPassword ? 1 : lines,
            readOnly: readOnly,
            onTap: onTap,
            keyboardType: keyboardType,
            obscureText: isPassword ? obscureText : false,
            style: const TextStyle(fontSize: 15.5, color: Color(0xFF1E293B)),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.5),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 21,
                        color: Colors.grey.shade500,
                      ),
                      onPressed: onTogglePassword,
                    )
                  : (icon != null
                        ? Icon(icon, size: 19, color: Colors.grey.shade500)
                        : null),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 15,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFF00A86B),
                  width: 1.6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}