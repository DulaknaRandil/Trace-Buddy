import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trace_buddy/ui/Login%20Screen/login_screen.dart';
import 'package:trace_buddy/ui/SignUp%20Screen/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/welcome.png',
              fit: BoxFit.cover,
            ),
          ),
          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Padding to move content upwards
                SizedBox(height: 350),
                // Explore Beauty of Sri Lanka Text
                Text(
                  'Explore Beauty\nof Sri Lanka',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSerifText(
                    color: Colors.white,
                    fontSize: 48,
                    letterSpacing: 1,
                    height: 1.2,
                  ),
                ),

                // Buttons Row
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Log In Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(226.36, 45.18),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Log in',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Sign Up Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => SignUpScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(226.36, 45.18),
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Sign up',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                // Padding to move content downwards

                Image.asset(
                  'assets/images/logo-with-name-stroke-1.png',
                  width: 84,
                  height: 84,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
