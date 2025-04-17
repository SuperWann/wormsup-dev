import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wormsup_dev/pages/homepage/homepage.dart';
import 'package:wormsup_dev/pages/widgets/alert.dart';
import 'package:wormsup_dev/view_model/login_view_model.dart';
import './registrasiPage.dart';
import '../widgets/input_form.dart';
import '../widgets/button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginpageState();
}

class _LoginpageState extends State<LoginPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      await LoginViewModel().signInWithEmailAndPassword(
        email: _controllerEmail.text.trim(),
        password: _controllerPassword.text.trim(),
      );
      _loginSucces();
    } on FirebaseAuthException catch (e) {
      switch ('${e.code}') {
        case 'network-request-failed':
          _showDialogFail("Terdapat kesalahan dalam jaringan, coba lagi nanti");
          break;
        case 'channel-error':
          _showDialogFail("Data tidak boleh kosong!");
          break;
        case 'invalid-email':
          _showDialogFail(
            "Alamat email atau kata sandi yang anda masukan salah",
          );
          break;
        case 'invalid-credential':
          _showDialogFail(
            "Alamat email atau kata sandi yang anda masukan salah",
          );
          break;
        default:
          _showDialogFail('${e.code}: ${e.message}');
      }
    }
  }

  void _loginSucces() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const Homepage(),
      ), // Ganti HomePage dengan halaman yang sesuai
      (Route<dynamic> route) => false,
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

  @override
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
                  'Selamat datang 🙋‍♂️',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                ),

                Text(
                  'Masukkan data diri anda',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                  ),
                ),

                SizedBox(height: 25),

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

                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Lupa Password?',
                    style: TextStyle(
                      color: Color(0xFF6B4F3B),
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                LongButton(
                  text: 'Masuk',
                  color: "#6B4F3B",
                  colorText: "#FFFFFF",
                  onPressed: _signInWithEmailAndPassword,
                ),

                SizedBox(height: 20),

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum punya akun?',
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
                                builder: (context) => RegistrasiPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Daftar',
                            style: TextStyle(
                              color: Color(0xFF6B4F3B),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // SizedBox(height: 25),

                    // Text(
                    //   'atau',
                    //   style: TextStyle(
                    //     fontFamily: 'Montserrat',
                    //     fontWeight: FontWeight.w400,
                    //     color: Colors.black26,
                    //   ),
                    // ),
                  ],
                ),

                // SizedBox(height: 25),

                // ButtonGoogle(text: 'Masuk dengan Google', onPressed: () {}),
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
