import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trace_buddy/controller/signup_controller.dart';
import 'package:trace_buddy/service/auth_service.dart';
import 'package:trace_buddy/ui/Login%20Screen/login_screen.dart';
import 'package:trace_buddy/ui/Sign%20Up%20Details/signup_details.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController _signUpController = SignUpController();
  final AuthService _authService = AuthService();

  bool _obscureText = true;
  bool _showConfirmPassword = false;

  @override
  void initState() {
    super.initState();
    _signUpController.passwordController.addListener(() {
      if (_signUpController.password.isNotEmpty) {
        setState(() {
          _showConfirmPassword = true;
        });
      } else {
        setState(() {
          _showConfirmPassword = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _signUpController.clearControllers();
    super.dispose();
  }

  Future<void> _handleGoogleSignIn() async {
    await _authService.googleSignIn();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpFinishScreen(),
      ),
    );
  }

  Future<void> _handleFacebookSignIn() async {
    await _authService.facebookSignIn();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpFinishScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

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
                'Register',
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
                'Create your new account',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 1.2,
                  color: Colors.black.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.05),
              buildTextField('Email Address', Icons.email, false,
                  _signUpController.emailController),
              SizedBox(height: 20),
              buildPasswordField(
                  'Password', _signUpController.passwordController),
              SizedBox(height: 10),
              if (_showConfirmPassword)
                buildTextField('Confirm Password', Icons.lock, true,
                    _signUpController.confirmPasswordController),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  '*By signing you agree to our terms and conditions',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    height: 1.8,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              ElevatedButton(
                onPressed: () async {
                  await _authService.signup(
                    email: _signUpController.email,
                    password: _signUpController.password,
                    context: context,
                  );
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
                  'Sign up',
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
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.black,
                      height: 1.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Login',
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
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility),
                color: Colors.black.withOpacity(0.6),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
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

  Widget buildPasswordField(String hintText, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: _obscureText,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.black.withOpacity(0.6),
        ),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.black.withOpacity(0.6),
        ),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          color: Colors.black.withOpacity(0.6),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
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
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
