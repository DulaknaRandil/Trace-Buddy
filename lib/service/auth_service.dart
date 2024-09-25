import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trace_buddy/ui/Navigation%20Bar/navigation_Bar.dart';
import 'package:trace_buddy/ui/Sign%20Up%20Details/signup_details.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(uid).get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>?;
      }
      return null;
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  bool _isValidEmail(String email) {
    // Basic email validation using regex
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    // Password validation: At least 8 characters, includes at least one letter and one number
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    return passwordRegex.hasMatch(password);
  }

  Future<void> signup(
      {required String email,
      required String password,
      required BuildContext context}) async {
    if (!_isValidEmail(email)) {
      _showToast("Please enter a valid email address.");
      return;
    }

    if (!_isValidPassword(password)) {
      _showToast(
          "Password must be at least 8 characters long, include both letters and numbers.");
      return;
    }

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => SignUpFinishScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message = "An account already exists with this email.";
      }
      _showToast(message);
    }
  }

  Future<void> signin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    if (email.isEmpty && password.isEmpty) {
      _showToast("Please enter your email and password.");
      return;
    }

    if (email.isEmpty) {
      _showToast("Please enter your email.");
      return;
    }

    if (password.isEmpty) {
      _showToast("Please enter your password.");
      return;
    }

    if (!_isValidEmail(email)) {
      _showToast("Please enter a valid email address.");
      return;
    }

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => NavigationBarScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'user-not-found') {
        message = "User not found for this email.";
      } else if (e.code == 'wrong-password') {
        message = "Wrong password..! Check again.";
      }
      _showToast(message);
    }
  }

  Future<void> signout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    _showToast("You have been signed out.");
  }

  Future<void> googleSignIn() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        _showToast("Successfully signed in with Google.");
      } else {
        _showToast("Google Sign-In was canceled.");
      }
    } catch (e) {
      _showToast("Google Sign-In failed. Please try again.");
    }
  }

  Future<void> facebookSignIn() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);

        await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
        _showToast("Successfully signed in with Facebook.");
      } else if (result.status == LoginStatus.cancelled) {
        _showToast("Facebook Sign-In was canceled.");
      } else {
        _showToast("Facebook Sign-In failed. Please try again.");
      }
    } catch (e) {
      _showToast("Facebook Sign-In failed. Please try again.");
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.red.shade400,
      textColor: Colors.white,
      fontSize: 14,
    );
  }

  Future<bool> checkUserExists(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      return userDoc.exists;
    } catch (e) {
      print("Error checking user existence: $e");
      return false;
    }
  }
}
