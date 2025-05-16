import 'package:flutter/material.dart';

import './loginPage.dart';
import './registrasiPage.dart';

import '../widgets/button.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(top: 30),
          child: Center(
            child: Text(
              'WormsUP',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Image.asset('assets/images/img_auth_page.png'),
                ),

                Column(
                  children: [
                    Text(
                      'Pemeliharaan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                        color: Colors.black,
                      ),
                    ),

                    Text(
                      'dalam genggaman',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 5),

                Text(
                  'Masuk untuk mulai mengontrol dan memantau dengan mudah.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: const Color.fromARGB(75, 0, 0, 0),
                  ),
                ),

                SizedBox(height: 65),

                LongButton(
                  text: 'Masuk',
                  color: "#6B4F3B",
                  colorText: "#FFFFFF",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),

                SizedBox(height: 10),

                LongButton(
                  text: 'Daftar',
                  color: "#FFFFFF",
                  colorText: "#6B4F3B",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrasiPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      backgroundColor: Colors.white,
    );
  }
}
