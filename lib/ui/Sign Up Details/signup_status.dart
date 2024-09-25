import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:trace_buddy/ui/Login%20Screen/login_screen.dart';
import 'package:trace_buddy/ui/Sign%20Up%20Details/signup_details.dart';

class SignUpStatusScreen extends StatelessWidget {
  final String status;

  SignUpStatusScreen({required this.status});

  @override
  Widget build(BuildContext context) {
    String assetPath;
    Widget animationWidget;

    if (status == 'success') {
      assetPath =
          'https://lottie.host/71dae10d-52ab-473f-b0d7-f6009c2f666c/HgOvi9m8qO.json';
      animationWidget = Lottie.network(
        assetPath,
        width: 200,
        height: 200,
      );
    } else {
      assetPath =
          'https://lottie.host/557d0bd4-73f1-45f7-8f6f-2c403012d2c9/Vf5gomlUet.json';
      animationWidget = Lottie.network(
        assetPath,
        width: 200,
        height: 200,
      );
    }

    // Redirect to appropriate screen after a delay
    Future.delayed(Duration(seconds: 3), () {
      if (status == 'success') {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LoginScreen())); // Redirect to LoginScreen
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SignUpFinishScreen())); // Redirect to SignUpScreen
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            animationWidget,
            SizedBox(height: 12),
            Text(
              status == 'success' ? 'Congratulations!' : 'Oops!',
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              status == 'success'
                  ? 'Account Setting Up Done'
                  : 'Something went wrong',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
