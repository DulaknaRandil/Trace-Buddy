import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trace_buddy/ui/Navigation%20Bar/navigation_Bar.dart';
import 'package:trace_buddy/ui/Slide%20Screen/slide_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return NavigationBarScreen();
          } else {
            return SlideScreen();
          }
        },
      ),
    );
  }
}
