import 'package:flutter/material.dart';
import 'features/splash_screen/screens/splash_screen.dart';

void main() {
  runApp(const FandomVerseApp());
}

class FandomVerseApp extends StatelessWidget {
  const FandomVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fandom Verse',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}