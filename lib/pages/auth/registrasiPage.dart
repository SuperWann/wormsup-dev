import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wormsup_dev/pages/widgets/alert.dart';

import './tokenPage.dart';
import './loginPage.dart';

import '../widgets/input_form.dart';
import '../widgets/button.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({super.key});

  @override
  State<RegistrasiPage> createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerKonfirmasiPassword =
      TextEditingController();

  @override
  Future<void> _signUp() async {
    if (_controllerPassword.text.trim() ==
        _controllerKonfirmasiPassword.text.trim()) {
      try {
        // await RegisterViewModel().createUserWithEmailAndPassword(
        //   email: _controllerEmail.text.trim(),
        //   password: _controllerPassword.text.trim(),
        // );
        // await RegisterViewModel().addUserDetails(
        //   username: _controllerUsername.text.trim(),
        //   email: _controllerEmail.text.trim(),
        // );
        _showTokenPage();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'network-request-failed':
            _showDialogFail(
              "Terdapat kesalahan dalam jaringan, coba lagi nanti",
            );
            break;
          case 'channel-error':
            _showDialogFail("Data tidak boleh kosong!");
            break;
          case 'invalid-email':
            _showDialogFail("Pastikan format alamat email anda benar");
            break;
          case 'email-already-in-use':
            _showDialogFail("Alamat email sudah terdaftar");
            break;
          default:
            _showDialogFail('${e.code}: ${e.message}');
        }
      }
    } else if (!usernameValidation(_controllerUsername)) {
      _showDialogFail("Pastikan karakter nama tidak terlalu pendek");
    } else {
      _showDialogFail('Pastikan kata sandi cocok');
    }
  }

  bool usernameValidation(TextEditingController username) {
    return _controllerUsername.text.length >= 3;
  }

  void _showTokenPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => TokenPage(
              username: _controllerUsername.text.trim(),
              email: _controllerEmail.text.trim(),
              password: _controllerPassword.text.trim(),
            ),
      ),
    );
  }

  void _showDialogFail(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return FailAlertState(
          message: message,
          onPressed: () => Navigator.pop(context),
        );
      },
    );
  }

  void dispose() {
    _controllerUsername.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerKonfirmasiPassword.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daftarkan diri anda',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                ),

                Text(
                  'Isi data diri dibawah',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                  ),
                ),

                SizedBox(height: 25),

                Text(
                  'Username',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 10),

                InputFormNoIcon(
                  text: 'Masukkan username',
                  controller: _controllerUsername,
                ),

                SizedBox(height: 10),

                Text(
                  'Email',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 10),

                InputFormNoIcon(
                  text: 'Masukkan email',
                  controller: _controllerEmail,
                ),

                SizedBox(height: 10),

                Text(
                  'Password',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 10),

                InputPassword(controller: _controllerPassword),

                SizedBox(height: 10),

                Text(
                  'Konfirmasi Password',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 10),

                InputPassword(controller: _controllerKonfirmasiPassword),

                SizedBox(height: 30),

                LongButton(
                  text: 'Daftar',
                  color: "#6B4F3B",
                  colorText: "#FFFFFF",
                  onPressed: _signUp,
                ),

                SizedBox(height: 20),

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sudah punya akun?',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Masuk',
                            style: TextStyle(
                              color: Color(0xFF6B4F3B),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 25),

                    Text(
                      'atau',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 25),

                ButtonGoogle(text: 'Masuk dengan Google', onPressed: () {}),
              ],
            ),
          ),

          Positioned(
            bottom: 20,
            left: 20,
            child: Text(
              'WormsUP v1',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/background_img_logo.png',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
