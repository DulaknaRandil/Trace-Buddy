import 'package:cloud_firestore/cloud_firestore.dart';

class PreviousSearchService {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<List<String>> getPreviousSearches(String userId) async {
    DocumentSnapshot userDoc = await _usersCollection.doc(userId).get();

    if (userDoc.exists && userDoc['previousSearches'] != null) {
      return List<String>.from(userDoc['previousSearches']);
    }
    return [];
  }

  Future<void> addSearchKeyword(String userId, String keyword) async {
    List<String> previousSearches = await getPreviousSearches(userId);

    if (previousSearches.length >= 5) {
      previousSearches.removeAt(0); // Remove the oldest keyword
    }

    previousSearches.add(keyword);

    await _usersCollection.doc(userId).set({
      'previousSearches': previousSearches,
    }, SetOptions(merge: true));
  }

  Future<void> deleteSearchKeyword(String userId, String keyword) async {
    List<String> previousSearches = await getPreviousSearches(userId);
    previousSearches.remove(keyword);

    await _usersCollection.doc(userId).set({
      'previousSearches': previousSearches,
    }, SetOptions(merge: true));
  }
}
