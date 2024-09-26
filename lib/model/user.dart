import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String firstName;
  String lastName;
  String role; // Replaced phoneNumber with role
  String gender; // Replaced country with gender
  String? imageUrl; // Add the imageUrl field

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.role, // Initialize role
    required this.gender, // Initialize gender
    this.imageUrl, // Initialize the imageUrl
  });

  // Convert a UserModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'role': role, // Include role in the map
      'gender': gender, // Include gender in the map
      'imageUrl': imageUrl, // Include the imageUrl in the map
    };
  }

  // Convert a map to a UserModel object
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      role: map['role'], // Retrieve the role from the map
      gender: map['gender'], // Retrieve the gender from the map
      imageUrl: map['imageUrl'], // Retrieve the imageUrl from the map
    );
  }

  // Save user data to Firestore
  Future<void> saveToFirestore(String userId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(toMap());
  }
}
