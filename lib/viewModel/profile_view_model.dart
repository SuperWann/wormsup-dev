import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileViewModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    String uid = _firebaseAuth.currentUser!.uid;
    return await _firestore.collection("users").doc(uid).get();
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
