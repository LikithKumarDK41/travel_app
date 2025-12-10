import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/not_found/not_found_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nara Travel Guide',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF2E5B3E),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E5B3E)),
      ),
      home: const SplashScreen(),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const NotFoundPage());
      },
    );
  }
}
