import 'package:flutter/material.dart';

class NewsletterWidget extends StatelessWidget {
  const NewsletterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5F0),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const Text("Stay ahead with Exclusive Deals.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          TextField(
            decoration: InputDecoration(
              hintText: "yourname@email.com",
              filled: true,
              fillColor: Colors.white,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send, color: Color(0xFF00A86B)),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }
}