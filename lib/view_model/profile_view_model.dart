import 'package:firebase_auth/firebase_auth.dart';

class ProfileViewModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
