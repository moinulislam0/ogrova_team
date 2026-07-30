import 'package:flutter/material.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1425),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(25),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(color: const Color(0xFF162136), borderRadius: BorderRadius.circular(30)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: Colors.black26, shape: BoxShape.circle, border: Border.all(color: Colors.white10)),
                child: const Icon(Icons.shopping_cart_outlined, color: Colors.green, size: 40),
              ),
              const SizedBox(height: 25),
              RichText(text: const TextSpan(style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), children: [TextSpan(text: "FIND "), TextSpan(text: "ACCOUNT", style: TextStyle(color: Color(0xFFADFF2F)))])),
              const Text("RECOVERY SERVICE", style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 2)),
              const SizedBox(height: 40),

              // OTP BOXES
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OtpInput(), OtpInput(), OtpInput(), OtpInput(),
                ],
              ),
              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFADFF2F), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: const Text("FIND ACCOUNT", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Remembered password? ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  GestureDetector(onTap: () {}, child: const Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class OtpInput extends StatelessWidget {
  const OtpInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(color: const Color(0xFF0D1B3E), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
      child: const TextField(
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(border: InputBorder.none, counterText: ""),
      ),
    );
  }
}