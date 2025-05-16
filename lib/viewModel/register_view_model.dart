import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterViewModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    //Buat user di Firebase Auth
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    //Ambil UID dari user yang baru saja dibuat
    String uid = userCredential.user!.uid;

    //Simpan data tambahan di Firestore
    await _firestore.collection("users").doc(uid).set({
      'username': username,
      'email': email,
    });
  }
}
