import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trace_buddy/model/user.dart';
import 'package:trace_buddy/ui/Navigation%20Bar/navigation_Bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  File? _image;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  String? _existingImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load existing user data when the screen initializes
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null) {
          _firstNameController.text = data['firstName'] ?? '';
          _lastNameController.text = data['lastName'] ?? '';
          _phoneNumberController.text = data['phoneNumber'] ?? '';
          _countryController.text = data['country'] ?? '';
          _existingImageUrl = data['imageUrl'];
        }
        setState(() {
          _firstNameController.text = data!['firstName'] ?? '';
          _lastNameController.text = data['lastName'] ?? '';
          _phoneNumberController.text = data['phoneNumber'] ?? '';
          _countryController.text = data['country'] ?? '';
          _existingImageUrl = data['imageUrl'];
        });
        await Future.delayed(Duration(seconds: 1));
        _existingImageUrl = data!['imageUrl'];
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        String? imageUrl = _existingImageUrl;
        if (_image != null) {
          // Upload the image to Firebase Storage
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('profile_images')
              .child('${user.uid}.jpg');
          final uploadTask = storageRef.putFile(_image!);
          final snapshot = await uploadTask.whenComplete(() {});
          imageUrl = await snapshot.ref.getDownloadURL();
        }

        // Save the updated data to Firestore
        final userModel = UserModel(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          phoneNumber: _phoneNumberController.text,
          country: _countryController.text,
          imageUrl: imageUrl, // Update the imageUrl if changed
        );

        await userModel.saveToFirestore(user.uid);

        // Show success message
        Fluttertoast.showToast(
          msg: "Profile updated successfully!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 14,
        );

        // Navigate to the NavigationBarScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationBarScreen(),
          ),
        );
      } catch (e) {
        // Show failure message
        Fluttertoast.showToast(
          msg: "Failed to update profile. Please try again.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.red.shade400,
          textColor: Colors.white,
          fontSize: 14,
        );
      }
    } else {
      // Handle case where the user is not signed in
      Fluttertoast.showToast(
        msg: "User not signed in.",
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
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Amber background container
                Container(
                  color: Colors.amber,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset('assets/back-button.svg'),
                      ),
                      Text(
                        'Update Profile',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 24), // Adjust as needed for spacing
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _pickImage(
                          ImageSource.gallery); // Pick image from gallery
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : _existingImageUrl != null
                              ? NetworkImage(_existingImageUrl!)
                              : AssetImage('assets/images/user.png')
                                  as ImageProvider,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.camera_alt,
                              color: Colors.red.shade400),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabelAndTextField(
                          'First Name', _firstNameController),
                      SizedBox(height: 16),
                      _buildLabelAndTextField('Last Name', _lastNameController),
                      SizedBox(height: 16),
                      _buildLabelAndTextField(
                          'Phone Number', _phoneNumberController),
                      SizedBox(height: 16),
                      _buildLabelAndTextField('Country', _countryController),
                      SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          onPressed:
                              _submitData, // Save the updated data when pressed
                          child: Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            textStyle: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to build a text field with a label
  Widget _buildLabelAndTextField(
      String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 4),
        TextField(
          cursorColor: Colors.black.withOpacity(0.7),
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          controller: controller,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.black),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
