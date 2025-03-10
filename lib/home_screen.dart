import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  void playSound(int soundNumber) {
    final player = AudioPlayer();
    player.play(AssetSource('note$soundNumber.wav'));
  }

  Expanded buildKey(
      int soundNumber,
      Color color,
      double horizontalPadding,
      double iconRightPadding,
      Color shadowColor,
      double iconSize,
      double iconShadowSize) {
    return Expanded(
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: 7, horizontal: horizontalPadding),
        child: TextButton(
          style: TextButton.styleFrom(
            shadowColor: shadowColor,
            elevation: 10,
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
          ),
          onPressed: () {
            playSound(soundNumber);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.only(right: iconRightPadding),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Shadow (slightly offset)
                    Icon(
                      Icons.circle,
                      size: iconShadowSize, // Slightly larger for shadow effect
                      color: Colors.black.withValues(alpha: 0.1),
                    ),
                    // Main Icon
                    Icon(
                      Icons.circle,
                      size: iconSize,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    size: iconShadowSize,
                    color: Colors.black.withValues(alpha: 0.1),
                  ),
                  Icon(
                    Icons.circle,
                    size: iconSize,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildKey1() {
    return Column(
      children: [
        Expanded(
          child: TextButton(
            style: TextButton.styleFrom(
              shadowColor: Colors.black,
              elevation: 10,
              backgroundColor: Colors.white,
              minimumSize: Size(35, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            onPressed: () {},
            child: Text(''),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    // Get screen height and width for responsive design
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth * 0.055;
    double iconShadowSize = screenWidth * 0.07;
    int? lastPlayedIndex;
    final buttons = [
      {'sound': 1},
      {'sound': 2},
      {'sound': 3},
      {'sound': 4},
      {'sound': 5},
      {'sound': 6},
      {'sound': 7},
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF44336), // Red
              Color(0xFFFF9800), // Orange
              Color(0xFFFFC107), // Amber
              Color(0xFF8BC34A), // Light Green
              Color(0xFF4CAF50), // Green
              Color(0xFF009688), // Teal
              Color(0xFF00BCD4), // Cyan
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(screenWidth * 0.02), // Adaptive margin
          decoration: BoxDecoration(
            border: Border.all(width: 7.0, color: Colors.white60),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Xylophone',
                style: TextStyle(
                  fontFamily: 'Agbalumo',
                  shadows: [
                    Shadow(
                      offset: Offset(0.0, 4.0),
                      color: Colors.white.withValues(alpha: 0.5),
                      blurRadius: 10,
                    ),
                  ],
                  fontSize: screenWidth * 0.08,
                  // Responsive font size
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.transparent,
            ),
            body: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildKey1(),
                    buildKey1(),
                  ],
                ),
                GestureDetector(
                  onVerticalDragUpdate: (details) {
                    // Define the bottom padding (space below the buttons, like SizedBox or any padding)
                    double bottomPadding = screenHeight * 0.1;

                    // Define the padding between buttons (if any)
                    double buttonSpacing = 7.0;

                    // Calculate usable height by excluding the bottom padding
                    double usableHeight = screenHeight - bottomPadding;

                    // Calculate the total height of all buttons including spacing
                    double totalButtonsHeight =
                        usableHeight - (buttons.length - 1) * buttonSpacing;

                    // Calculate the button height based on the usable height, excluding spacing
                    final buttonHeight = totalButtonsHeight / buttons.length;

                    // Calculate the index based on swipe position
                    final index = (details.localPosition.dy / buttonHeight)
                        .clamp(0.0, buttons.length - 1)
                        .toInt();

                    // Play sound only if a new button is swiped over
                    if (index != lastPlayedIndex) {
                      lastPlayedIndex = index;
                      playSound(buttons[index]['sound'] as int);
                    }
                  },
                  onVerticalDragEnd: (details) {
                    lastPlayedIndex = null; // Reset after swipe ends
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: screenHeight * 0.03),
                      // Adaptive spacing
                      buildKey(
                          1,
                          Color(0xFF00BCD4),
                          screenWidth * 0.12,
                          screenWidth * 0.3,
                          Color(0xFF00BCD4),
                          iconSize,
                          iconShadowSize),
                      // Cyan
                      buildKey(
                          2,
                          Color(0xFF009688),
                          screenWidth * 0.11,
                          screenWidth * 0.28,
                          Color(0xFF009688),
                          iconSize,
                          iconShadowSize),
                      // Teal
                      buildKey(
                          3,
                          Color(0xFF4CAF50),
                          screenWidth * 0.1,
                          screenWidth * 0.26,
                          Color(0xFF4CAF50),
                          iconSize,
                          iconShadowSize),
                      // Green
                      buildKey(
                          4,
                          Color(0xFF8BC34A),
                          screenWidth * 0.09,
                          screenWidth * 0.24,
                          Color(0xFF8BC34A),
                          iconSize,
                          iconShadowSize),
                      // Light Green
                      buildKey(
                          5,
                          Color(0xFFFFC107),
                          screenWidth * 0.08,
                          screenWidth * 0.22,
                          Color(0xFFFFC107),
                          iconSize,
                          iconShadowSize),
                      // Amber
                      buildKey(
                          6,
                          Color(0xFFFF9800),
                          screenWidth * 0.07,
                          screenWidth * 0.20,
                          Color(0xFFFF9800),
                          iconSize,
                          iconShadowSize),
                      // Orange
                      buildKey(
                          7,
                          Color(0xFFF44336),
                          screenWidth * 0.06,
                          screenWidth * 0.18,
                          Color(0xFFF44336),
                          iconSize,
                          iconShadowSize),
                      // Red
                      SizedBox(
                        height: screenHeight * 0.04, // Adaptive height
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Developed by: Waleed Taj',
                              style: TextStyle(
                                fontFamily: 'Agbalumo',
                                shadows: [
                                  Shadow(
                                    offset: Offset(0.0, 4.0),
                                    color: Colors.black.withValues(alpha: 0.5),
                                    blurRadius: 10,
                                  ),
                                ],
                                fontSize: screenWidth * 0.03,
                                // Adaptive font size
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
