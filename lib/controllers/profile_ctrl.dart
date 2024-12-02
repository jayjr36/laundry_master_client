import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateUserProfile(String name, String email, String phoneNumber) async {
    try {
      String userId = _auth.currentUser!.uid;

      // Update Firestore data
      await _firestore.collection('users').doc(userId).update({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
      });

      // Optionally update email in FirebaseAuth
      if (email != _auth.currentUser!.email) {
        await _auth.currentUser!.updateEmail(email);
      }
    } catch (e) {
      throw Exception("Failed to update profile: $e");
    }
  }
}
