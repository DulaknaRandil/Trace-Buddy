import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../Welcome Screen/welcome_screen.dart';

class SlideScreen extends StatefulWidget {
  @override
  _SlideScreenState createState() => _SlideScreenState();
}

class _SlideScreenState extends State<SlideScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<String> images = [
    "assets/images/1ffcf559067459774a9e9ea32838f35a 1.png",
    "assets/images/6c0f7018436633dff222523e9ff2a937 1.png",
    "assets/images/3ee9d88611d847eb92ebbd4c53d04d31 1.png",
  ];

  List<String> titles = [
    "Welcome to",
    "Your personal writing coach, tailored to",
    "Easily track your completed tasks and"
  ];

  List<String> subtitles = [
    "TraceBuddy!",
    "your pace and progress !",
    "See how far you’ve come !"
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _skipToLogin(BuildContext context) {
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(builder: (ctx) => WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: images.length,
            itemBuilder: (context, index) {
              double titleFontSize = screenWidth * 0.075;
              double subtitleFontSize = screenWidth * 0.03;
              double titlePositionBottom = screenHeight * 0.15;
              double titlePositionLeft = screenWidth * 0.05;
              double titlePositionRight = screenWidth * 0.05;
              TextAlign titleTextAlign = TextAlign.center;
              TextStyle subtitleStyle;
              MainAxisAlignment columnAlignment = MainAxisAlignment.center;

              if (index == 0) {
                // Modifying index 0 to align text at the top-left
                titlePositionBottom =
                    screenHeight * 0.70; // Push the text upwards
                titlePositionLeft =
                    screenWidth * 0.05; // Align text to the left
                titlePositionRight = screenWidth * 0.05;
                titleTextAlign = TextAlign.left;
                columnAlignment = MainAxisAlignment.start;

                subtitleStyle = GoogleFonts.poppins(
                  fontSize: subtitleFontSize,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                );
              } else if (index == 1) {
                titleFontSize = screenWidth * 0.038;
                subtitleFontSize = screenWidth * 0.039;
                titlePositionBottom = screenHeight * 0.10;
                titlePositionLeft = screenWidth * 0.08;
                titleTextAlign = TextAlign.center;
                columnAlignment = MainAxisAlignment.start;
                subtitleStyle = GoogleFonts.poppins(
                  fontSize: subtitleFontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                );
              } else if (index == 2) {
                titleFontSize = screenWidth * 0.042;
                subtitleFontSize = screenWidth * 0.042;
                titlePositionBottom = screenHeight * 0.18;
                titlePositionLeft = screenWidth * 0.037;
                titleTextAlign = TextAlign.center;
                subtitleStyle = GoogleFonts.poppins(
                    fontSize: subtitleFontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    height: 1);
              } else {
                subtitleStyle = TextStyle();
              }

              return Stack(
                children: [
                  Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    color: Colors.white
                        .withOpacity(0.7), // Adjust opacity as needed
                  ),
                  if (index != 2)
                    Positioned(
                      top: screenHeight * 0.1,
                      right: screenWidth * 0.06,
                      child: GestureDetector(
                        onTap: () => _skipToLogin(context),
                        child: Stack(
                          children: [
                            SvgPicture.asset(
                              "assets/vectors/rectangle-15.svg",
                              width: screenWidth * 0.12,
                              height: screenHeight * 0.03,
                            ),
                            Positioned(
                              top: screenHeight * 0.0045,
                              left: screenWidth * 0.044,
                              child: Text(
                                "Skip >",
                                style: GoogleFonts.inter(
                                  fontSize: screenWidth * 0.03,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: -0.32,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: index == 0
                        ? screenHeight * 0.70
                        : titlePositionBottom, // Adjust title position for index 0
                    left: titlePositionLeft,
                    right: titlePositionRight,
                    child: Column(
                      crossAxisAlignment: (index == 1)
                          ? CrossAxisAlignment.center
                          : (index == 2)
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment
                                  .start, // Align to start for index 0
                      mainAxisAlignment: columnAlignment,
                      children: [
                        if (index == 0) ...[
                          Text(
                            titles[index],
                            style: GoogleFonts.poppins(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              color: Colors.black,
                            ),
                            textAlign: titleTextAlign,
                          ),
                          Text(
                            subtitles[index],
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              letterSpacing: 0,
                            ),
                            textAlign: titleTextAlign,
                          ),
                        ] else ...[
                          Text(
                            titles[index],
                            style: GoogleFonts.poppins(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: Colors.black,
                            ),
                            textAlign: titleTextAlign,
                          ),
                          Text(
                            subtitles[index],
                            style: subtitleStyle,
                            textAlign: titleTextAlign,
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (index == 0) // Only show on index 0
                    Positioned(
                      bottom: screenHeight * 0.1 + screenHeight * 0.01,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          "Personalized Learning Experience",
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  if (index == 2)
                    Positioned(
                      bottom: screenHeight * 0.1,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            _skipToLogin(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.04),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.01,
                                horizontal: screenWidth * 0.04),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Get Started",
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              SvgPicture.asset(
                                "assets/vectors/vector-6.svg",
                                width: screenWidth * 0.02,
                                height: screenHeight * 0.015,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: screenHeight * 0.05,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                        (index) => buildDot(index, context),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenWidth * 0.02,
      width: _currentPage == index ? screenWidth * 0.05 : screenWidth * 0.02,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
      decoration: BoxDecoration(
        color: _currentPage == index
            ? Colors.black
            : Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(screenWidth * 0.01),
      ),
    );
  }
}
