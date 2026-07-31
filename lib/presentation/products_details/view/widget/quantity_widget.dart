import 'package:flutter/material.dart';
import 'package:ogrova_team/core/resource/constant/color_manager.dart';

class QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const QuantityButton({super.key, required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ColorManager.primary),
        ),
        child: Icon(icon, size: 22, color: ColorManager.primary),
      ),
    );
  }
}
