import 'package:flutter/material.dart ';
import 'package:wormsup_dev/view_model/profile_view_model.dart';
import 'package:wormsup_dev/pages/auth/authPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<void> signOut() async {
    await ProfileViewModel().signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => AuthPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selamat datang di Homepage Iwennn'),
            TextButton(onPressed: signOut, child: Text('Logout')),
          ],
        ),
      ),
    );
  }
}
