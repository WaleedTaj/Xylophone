import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    // Get screen height and width for responsive design
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      // backgroundColor: Color(0xFFFCABAF),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    maxRadius: screenWidth *
                        0.2, // Responsive radius based on screen width
                    foregroundImage:
                        AssetImage('assets/images/Xylophone App Icon.png'),
                  ),
                  SizedBox(height: screenHeight * 0.02), // Adaptive spacing
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        Color(0xFFF44336), // Red
                        Color(0xFFFF9800), // Orange
                        Color(0xFFFFC107), // Amber
                        Color(0xFF8BC34A), // Light Green
                        Color(0xFF4CAF50), // Green
                        Color(0xFF009688), // Teal
                        Color(0xFF00BCD4), // Cyan
                      ],
                    ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                    child: Text(
                      'Xylophone',
                      style: TextStyle(
                        fontFamily: 'Agbalumo',
                        fontSize: screenWidth * 0.08, // Adaptive font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05), // Adaptive spacing
                  SizedBox(
                    height: screenHeight * 0.07, // Adaptive height
                    child: LoadingIndicator(
                      indicatorType: Indicator.audioEqualizer,
                      colors: [
                        Color(0xFFF44336), // Red
                        Color(0xFFFF9800), // Orange
                        Color(0xFF4CAF50), // Green
                        Color(0xFF00BCD4), // Cyan
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    EdgeInsets.all(screenWidth * 0.05), // Responsive padding
                child: Text(
                  'Developed by: Waleed Taj',
                  style: TextStyle(
                    fontFamily: 'Agbalumo',
                    fontSize: screenWidth * 0.03, // Adaptive font size
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
