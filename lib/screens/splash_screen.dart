import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'home_screen.dart'; 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white, // Warna pertama
              Colors.purple, // Warna kedua
            ],
          ),
        ),
        child: Center(
          child: AspectRatio(
            aspectRatio: 1, // Pastikan rasio animasi selalu proporsional (1:1)
            child: Lottie.asset(
              'assets/lottie/animation_ur.json', 
              fit: BoxFit.contain,
              onLoaded: (composition) {
               
                Future.delayed(composition.duration, () {
                  Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
