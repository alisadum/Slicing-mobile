import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/cart.dart';         // Sesuaikan dengan nama file yang ada
import 'screens/check_out.dart';    // Sesuaikan dengan nama file yang ada

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Menu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      routes: {
        '/cart': (context) => const CartScreen(),        
        '/checkout': (context) => const CheckoutScreen(), 
      },
    );
  }
}