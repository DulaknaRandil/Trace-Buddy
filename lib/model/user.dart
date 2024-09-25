import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String firstName;
  String lastName;
  String phoneNumber;
  String country;
  String? imageUrl; // Add the imageUrl field

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.country,
    this.imageUrl, // Initialize the imageUrl
  });

  // Convert a UserModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'country': country,
      'imageUrl': imageUrl, // Include the imageUrl in the map
    };
  }

  // Convert a map to a UserModel object
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      phoneNumber: map['phoneNumber'],
      country: map['country'],
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
