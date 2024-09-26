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
              'assets/images/1ffcf559067459774a9e9ea32838f35a 1.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.8), // Adjust opacity as needed
          ),
          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Padding to move content upwards
                SizedBox(height: 150),
                // Explore Beauty of Sri Lanka Text
                Image.asset(
                  'assets/images/09736d19e3183b83891293083362bc75 1.png',
                  fit: BoxFit.cover,
                ),

                // Buttons Row
                SizedBox(height: 20),
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
                        backgroundColor: Colors.lightBlueAccent.shade200,
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
                        backgroundColor:
                            const Color.fromARGB(255, 10, 217, 124),
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
                  'assets/images/logo.png',
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
