import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _infoCard(Icons.local_shipping, "Free Shipping"),
          _infoCard(Icons.support_agent, "24x7 Support"),
          _infoCard(Icons.verified_user, "Secure Payment"),
        ],
      ),
    );
  }

  Widget _infoCard(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF00A86B), size: 30),
        const SizedBox(height: 5),
        Text(text, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
      ],
    );
  }
}