import 'package:flutter/material.dart';
import 'package:ogrova_team/core/resource/constant/image_manager.dart';
import 'package:ogrova_team/presentation/auth/otp_screen/view/screen/otp_screen.dart';


class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1425),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(25),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: const Color(0xFF162136),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo Section
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Image.asset(ImageManager.logo, height: 50, width: 70),
                ),
                const SizedBox(height: 25),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: "FIND "),
                      TextSpan(
                        text: "ACCOUNT",
                        style: TextStyle(color: Color(0xFFADFF2F)),
                      ),
                    ],
                  ),
                ),
                const Text(
                  "RECOVERY SERVICE",
                  style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 2),
                ),
                const SizedBox(height: 40),

                // Email Input
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "REGISTERED EMAIL",
                    style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "you@example.com",
                    hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
                    prefixIcon: const Icon(Icons.email_outlined, color: Colors.white38, size: 20),
                    filled: true,
                    fillColor: const Color(0xFF0D1B3E),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 35),

                // Find Account Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                    
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  OtpScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFADFF2F),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      "FIND ACCOUNT",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Remembered password? ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}