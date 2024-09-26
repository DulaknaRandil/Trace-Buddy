import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trace_buddy/service/auth_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Use a Timer to navigate after 15 seconds
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (ctx) => AuthPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 252, 250),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 5),
            Image.asset(
              "assets/images/logo.png",
              width: 240,
              height: 240,
            ),
            Spacer(flex: 4),
            Text(
              'Developed By',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.2,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              'Team GreenBYTE',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
                height:
                    30), // Adjust height for better spacing on different devices
          ],
        ),
      ),
    );
  }
}
