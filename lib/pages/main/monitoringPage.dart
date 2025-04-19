import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wormsup_dev/pages/auth/authPage.dart';
import 'package:wormsup_dev/viewModel/profile_view_model.dart';

class MonitoringPage extends StatelessWidget {
  const MonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthPage(),
            ), // Ganti HomePage dengan halaman yang sesuai
            (Route<dynamic> route) => false,
          );
        },
        child: Text('Logout'),
      ),
    );
  }
}
