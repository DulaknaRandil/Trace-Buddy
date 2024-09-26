import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trace_buddy/ui/Login%20Screen/login_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  void _sendPasswordResetEmail() async {
    final email = _emailController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your email')),
      );
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
        msg: "Rest Password link sent to your email",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red.shade400,
        textColor: Colors.white,
        fontSize: 14,
      );
      await Future.delayed(const Duration(seconds: 1));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Fail to send Email",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red.shade400,
        textColor: Colors.white,
        fontSize: 14,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16),
              IconButton(
                icon: SvgPicture.asset('assets/back-button.svg'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 200),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Forget Password",
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                        height: 1.2,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Enter your email to verification",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.email,
                            color: Colors.black.withOpacity(0.6),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _emailController,
                              style: TextStyle(color: Colors.black),
                              cursorColor: Colors.black.withOpacity(0.6),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email Address',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: 1,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    Container(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .lightBlueAccent.shade200, // background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _sendPasswordResetEmail,
                        child: Text(
                          'Verify',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
