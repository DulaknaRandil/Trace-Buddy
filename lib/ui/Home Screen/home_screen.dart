import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  // Navigation function for each game
  void navigateToGame(BuildContext context, String game) {
    // You can define actual navigation to different screens here
    // For demonstration purposes, we'll just print the game name
    print("Navigating to $game");
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  color: Color.fromARGB(255, 9, 217, 141),
                ),
                Positioned(
                  top: 15,
                  right: 20,
                  child: SvgPicture.asset(
                    'assets/vectors/bell-pin-fill.svg',
                    width: 30,
                    height: 30,
                  ),
                ),
                Positioned(
                  top: 15,
                  left: 13,
                  child: Text(
                    'Hi, Lahiru 👋',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        letterSpacing: -0.32,
                        color: Colors.white),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 13,
                  right: 13,
                  child: Image.asset(
                    'assets/images/Mask group.png',
                    width: screenWidth - 26,
                    height: 106,
                  ),
                ),
              ],
            ),
            // Game Center Title
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Text(
                'Game Center',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ),
            // Game Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      gameCard(
                          'assets/images/e9f8157d995fd773274140bcac9b6bd6 1.png',
                          'Letter Challenge',
                          context),
                      gameCard(
                          'assets/images/55c2ec614965f0f7d29d85c3d5dddfc4 1.png',
                          'Number Challenge',
                          context),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      gameCard(
                          'assets/images/741a45ab915c18e3b9e0fb6e44758ece 1.png',
                          'Word Challenge',
                          context),
                      gameCard(
                          'assets/images/8bcdab24cc141fb02ee50f20e0ad43f8 1.png',
                          'Paragraph Challenge',
                          context)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gameCard(String imagePath, String title, BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToGame(context, title);
      },
      child: Container(
        width: 167,
        height: 209.75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 0),
              blurRadius: 0,
            ),
          ],
        ),
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              width: 167,
              height: 209.75,
            ),
            Positioned(
              bottom: 10,
              left: 20,
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
