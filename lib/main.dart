import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/cart.dart';
import 'screens/check_out.dart';
import 'screens/history.dart';
import 'screens/home_screen.dart';

// Global variable to store transaction history
List<Map<String, dynamic>> transactionHistory = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 244, 247, 72)),
        useMaterial3: true,
      ),
      initialRoute: '/', // Start from splash screen
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/cart': (context) => CartScreen(
              cartItems: const [],
              onCheckout: () {
                // Handle checkout logic here
              },
            ),
        '/checkout': (context) => CheckoutScreen(
              cartItems: transactionHistory.isNotEmpty
                  ? List<Map<String, dynamic>>.from(transactionHistory.last['items'] ?? [])
                  : [],
            ),
        '/history': (context) => const HistoryScreen(),
      },
    );
  }
}
