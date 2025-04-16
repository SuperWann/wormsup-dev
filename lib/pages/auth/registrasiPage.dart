import 'package:flutter/material.dart';
import './loginPage.dart';
import '../widgets/input_form.dart';
import '../widgets/button.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({super.key});

  @override
  State<RegistrasiPage> createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerKonfirmasiPassword =
      TextEditingController();

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
                  'Nama Lengkap',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 10),

                InputFormNoIcon(
                  text: 'Masukkan nama lengkap',
                  controller: _controllerNama,
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
                  onPressed: () {},
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
