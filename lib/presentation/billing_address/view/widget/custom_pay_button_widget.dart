import 'package:flutter/material.dart';

class BottomPayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text("৳ 3,824", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF00A86B))),
                  Text("VAT INCLUDED", style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00A86B), padding: const EdgeInsets.symmetric(vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Proceed to Payment  ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
