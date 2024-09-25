import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:fluttertoast/fluttertoast.dart'; // Import Fluttertoast for showing errors
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:google_sign_in/google_sign_in.dart'; // Import GoogleSignIn
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:trace_buddy/controller/signin_controller.dart';
import 'package:trace_buddy/service/auth_service.dart';
import 'package:trace_buddy/ui/Forget%20Password/forget_password.dart';
import 'package:trace_buddy/ui/Navigation%20Bar/navigation_Bar.dart';
import 'package:trace_buddy/ui/SignUp%20Screen/signup_screen.dart'; // Import FacebookAuth

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final SignInController signInController = SignInController();
    final AuthService _authService = AuthService();

    Future<void> _handleGoogleSignIn() async {
      await _authService.googleSignIn();
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        bool userExists = await _authService.checkUserExists(user.uid);
        if (userExists) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NavigationBarScreen(),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: "User data does not exist. Please register.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.red.shade400,
            textColor: Colors.white,
            fontSize: 14,
          );
        }
      }
    }

    Future<void> _handleFacebookSignIn() async {
      await _authService.facebookSignIn();
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        bool userExists = await _authService.checkUserExists(user.uid);
        if (userExists) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NavigationBarScreen(),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: "User data does not exist. Please register.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.red.shade400,
            textColor: Colors.white,
            fontSize: 14,
          );
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.265),
              Text(
                'Welcome',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                  height: 1.2,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Login to your account',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 1.2,
                  color: Colors.black.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.05),
              buildTextField(
                'Email Address',
                Icons.email,
                false,
                signInController.emailController,
              ),
              SizedBox(height: 20),
              buildTextField(
                'Password',
                Icons.lock,
                true,
                signInController.passwordController,
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (ctx) => ForgetPasswordScreen()),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              ElevatedButton(
                onPressed: () {
                  _authService.signin(
                      email: signInController.emailController.text,
                      password: signInController.passwordController.text,
                      context: context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.2, vertical: 12),
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
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Or continue with',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 1.2,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  socialButton('assets/images/google.png', _handleGoogleSignIn),
                  SizedBox(width: 20),
                  socialButton(
                      'assets/images/facebook.png', _handleFacebookSignIn),
                ],
              ),
              SizedBox(height: screenHeight * 0.1),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Don’t have an account? ',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.black,
                      height: 1.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Register',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hintText, IconData icon, bool obscureText,
      TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.black.withOpacity(0.6),
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.black.withOpacity(0.6),
        ),
        suffixIcon: obscureText
            ? IconButton(
                icon: Icon(Icons.visibility_off),
                color: Colors.black.withOpacity(0.6),
                onPressed: () {
                  // Add logic to toggle password visibility
                },
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      ),
      cursorColor: Colors.black,
    );
  }

  Widget socialButton(String imagePath, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Image.asset(
          imagePath,
          width: 35,
          height: 35,
        ),
      ),
    );
  }
}
