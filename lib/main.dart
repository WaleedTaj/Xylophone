import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() => runApp(Xylophone());

class Xylophone extends StatelessWidget {
  const Xylophone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
