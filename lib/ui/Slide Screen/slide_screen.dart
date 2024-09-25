import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trace_buddy/ui/Welcome%20Screen/welcome_screen.dart';

class SlideScreen extends StatefulWidget {
  @override
  _SlideScreenState createState() => _SlideScreenState();
}

class _SlideScreenState extends State<SlideScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<String> images = [
    "assets/images/c_50_d_919929458_cdb_8673_eb_7_fc_0513409.png",
    "assets/images/f_4_e_17_b_568_f_5592_f_0_dcf_5_c_9278_d_8_f_5562.png",
    "assets/images/cdb_88_dbb_8_f_59_c_5_a_651_ea_081_e_97_fa_1.png",
    "assets/images/splash.png",
  ];

  List<String> titles = [
    "AYUBOWAN!",
    "Discover Sri Lanka’s",
    "Ascend to",
    "Escape to Paradise"
  ];

  List<String> subtitles = [
    "Welcome to the Perl of the Indian Ocean",
    "Hidden Gems",
    "new heights",
    "   Start Sri Lankan"
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
    // Get screen width and height
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
              // Calculate sizes and positions dynamically
              double titleFontSize = screenWidth * 0.1;
              double subtitleFontSize = screenWidth * 0.03;
              double titlePositionBottom = screenHeight * 0.15;
              double titlePositionLeft = screenWidth * 0.05;
              double titlePositionRight = screenWidth * 0.05;
              TextAlign titleTextAlign = TextAlign.center;
              TextStyle subtitleStyle;
              MainAxisAlignment columnAlignment = MainAxisAlignment.center;

              // Adjust styles and positions for each slide
              if (index == 0) {
                titleTextAlign = TextAlign.center;
                subtitleStyle = GoogleFonts.poppins(
                  fontSize: subtitleFontSize,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                );
              } else if (index == 1) {
                titleFontSize = screenWidth * 0.08;
                subtitleFontSize = screenWidth * 0.1;
                titlePositionBottom = screenHeight * 0.10;
                titlePositionLeft = screenWidth * 0.08;
                titleTextAlign = TextAlign.left;
                columnAlignment = MainAxisAlignment.start;
                subtitleStyle = GoogleFonts.dmSerifText(
                  fontSize: subtitleFontSize,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                );
              } else if (index == 2) {
                titleFontSize = screenWidth * 0.068;
                subtitleFontSize = screenWidth * 0.07;
                titlePositionBottom = screenHeight * 0.69;
                titlePositionLeft = screenWidth * 0.05;
                titlePositionRight = screenWidth * 0.05;
                titleTextAlign = TextAlign.left;
                columnAlignment = MainAxisAlignment.start;
                subtitleStyle = GoogleFonts.dmSerifText(
                  fontSize: subtitleFontSize,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                );
              } else if (index == 3) {
                titleFontSize = screenWidth * 0.08;
                subtitleFontSize = screenWidth * 0.08;
                titlePositionBottom = screenHeight * 0.32;
                titlePositionLeft = screenWidth * 0.24;
                titleTextAlign = TextAlign.right;
                subtitleStyle = GoogleFonts.dmSerifText(
                    fontSize: subtitleFontSize,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 0.2);
              } else {
                subtitleStyle =
                    TextStyle(); // Add this line to assign an initial value to subtitleStyle
              }

              return Stack(
                children: [
                  Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  if (index != 3)
                    Positioned(
                      top: screenHeight * 0.1,
                      right: screenWidth * 0.06,
                      child: GestureDetector(
                        onTap: () => _skipToLogin(context),
                        child: Stack(
                          children: [
                            SvgPicture.asset(
                              "assets/rectangle-15.svg",
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
                    bottom: titlePositionBottom,
                    left: titlePositionLeft,
                    right: titlePositionRight,
                    child: Column(
                      crossAxisAlignment: (index == 1 || index == 2)
                          ? CrossAxisAlignment.start
                          : (index == 3)
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.center,
                      mainAxisAlignment: columnAlignment,
                      children: [
                        Text(
                          titles[index],
                          style: GoogleFonts.dmSerifText(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1,
                            color: Colors.white,
                            height: index == 3 ? 2 : 1,
                          ),
                          textAlign: titleTextAlign,
                        ),
                        if (index != 2)
                          Text(
                            subtitles[index],
                            style: subtitleStyle,
                            textAlign: titleTextAlign,
                          ),
                        if (index == 2) SizedBox(height: screenHeight * 0.01),
                        if (index == 2)
                          Text(
                            "new heights",
                            style: GoogleFonts.dmSerifText(
                              fontSize: screenWidth * 0.068,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            textAlign: titleTextAlign,
                          ),
                        if (index == 2)
                          Text(
                            "in Sri Lanka",
                            style: GoogleFonts.dmSerifText(
                              fontSize: screenWidth * 0.08,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        if (index == 3)
                          Wrap(
                            verticalDirection: VerticalDirection.down,
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: [
                              Text(
                                "Adventure",
                                style: GoogleFonts.dmSerifText(
                                  fontSize: screenWidth * 0.08,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                                textAlign: titleTextAlign,
                              ),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              Text(
                                "Today",
                                style: GoogleFonts.dmSerifText(
                                  fontSize: screenWidth * 0.09,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                                textAlign: titleTextAlign,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  if (index == 3)
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
                            backgroundColor: Colors.red,
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
                                "assets/vector-6.svg",
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
        color: _currentPage == index ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.circular(screenWidth * 0.01),
      ),
    );
  }
}
