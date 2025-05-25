import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AuthService with ChangeNotifier {
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

  // Getter untuk mengambil user yang sedang login saat ini
  // Bisa bernilai null jika tidak ada user yang login
  User? get currUser => _firebaseAuth.currentUser;

  // Getter untuk listen (mendengarkan) perubahan status login user
  // Misalnya: user login, logout, atau akun dihapus
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Memberi tahu listener (misal: UI) bahwa ada perubahan data
    // Biasanya digunakan untuk memicu rebuild pada widget
    notifyListeners();
  }
}