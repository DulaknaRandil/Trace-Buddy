import 'package:flutter/material.dart';

class SignUpController with ChangeNotifier {
  // Controllers for managing text input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Getters to access the text directly
  String get email => _emailController.text;
  String get password => _passwordController.text;
  String get confirmPassword => _confirmPasswordController.text;

  // Expose the controllers to use them in the UI
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  // Method to clear all controllers
  void clearControllers() {
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  // Dispose the controllers when they are no longer needed
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
