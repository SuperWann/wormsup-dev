import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
