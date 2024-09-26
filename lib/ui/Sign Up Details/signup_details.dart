import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:trace_buddy/model/user.dart';
import 'package:trace_buddy/ui/Sign%20Up%20Details/signup_status.dart';

class SignUpFinishScreen extends StatefulWidget {
  @override
  _SignUpFinishScreenState createState() => _SignUpFinishScreenState();
}

class _SignUpFinishScreenState extends State<SignUpFinishScreen> {
  File? _image;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String? _role; // Dropdown for role
  String? _gender; // Radio button for gender

  // List of roles for dropdown
  List<String> roles = ['Teacher', 'Student', 'Parent'];

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
      String? imageUrl;
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

      final userModel = UserModel(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        role: _role!, // Role value from dropdown
        gender: _gender!, // Gender value from radio buttons
        imageUrl: imageUrl, // Set the imageUrl
      );

      await userModel.saveToFirestore(user.uid);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpStatusScreen(status: 'success'),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpStatusScreen(status: 'fail'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                IconButton(
                  icon: SvgPicture.asset('assets/back-button.svg'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 50),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Finish Signing Up',
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          letterSpacing: 0.2,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 47,
                            backgroundColor: Colors.lightBlueAccent.shade200,
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.9),
                              radius: 46,
                              backgroundImage:
                                  _image != null ? FileImage(_image!) : null,
                              child: _image == null
                                  ? Icon(
                                      Icons.person,
                                      size: 46,
                                      color: Colors.grey,
                                    )
                                  : null,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                _showImagePickerOptions(context);
                              },
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.lightBlueAccent.shade200,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                      _buildTextField('First Name', _firstNameController),
                      SizedBox(height: 16),
                      _buildTextField('Last Name', _lastNameController),
                      SizedBox(height: 16),

                      // Dropdown for Role
                      // Dropdown for Role
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: _role,
                          dropdownColor: Colors
                              .white, // Set the dropdown background color to white
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Role',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black45,
                            ),
                          ),
                          items: roles.map((String role) {
                            return DropdownMenuItem<String>(
                              value: role,
                              child: Text(role,
                                  style: TextStyle(color: Colors.black)),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _role = newValue;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a role';
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(height: 16),

                      // Radio buttons for Gender
                      Padding(
                        padding: const EdgeInsets.only(right: 275),
                        child: Text(
                          'Gender',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListTile(
                              title: const Text('Male',
                                  style: TextStyle(color: Colors.black)),
                              leading: Radio<String>(
                                activeColor: Colors.black,
                                value: 'Male',
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: const Text('Female',
                                  style: TextStyle(color: Colors.black)),
                              leading: Radio<String>(
                                activeColor: Colors.black,
                                value: 'Female',
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
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
                          onPressed: _submitData,
                          child: Text(
                            'Submit',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 80),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigate to Privacy Policy
                            },
                            child: Text(
                              'Privacy Policy',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 4),
                          GestureDetector(
                            onTap: () {
                              // Navigate to Terms & Conditions
                            },
                            child: Text(
                              'Terms & Conditions',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
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

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black45,
          ),
        ),
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }
}
