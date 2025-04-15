import 'package:flutter/material.dart';
import './pages/auth/authPage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => AuthPage()));
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              child: Image.asset('images/wormsup_logo.png'),
            ),
            SizedBox(height: 10),
            Text(
              'WormsUP',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),

      backgroundColor: Color(0xFF6B4F3B),
    );
  }
}
