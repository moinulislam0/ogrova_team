import 'package:flutter/material.dart';
import 'package:ogrova_team/core/resource/constant/color_manager.dart';
import 'package:ogrova_team/core/resource/constant/image_manager.dart';

import 'package:ogrova_team/presentation/main_screen/view/screen/main_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
         
            Image.asset(
              ImageManager.logo, 
              width: 200,
            ),
            const SizedBox(height: 20),
          
            const CircularProgressIndicator(
              color: ColorManager.primary,
            ),
          ],
        ),
      ),
    );
  }
}