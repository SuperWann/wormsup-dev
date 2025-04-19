import 'package:flutter/material.dart';
import 'package:wormsup_dev/pages/auth/loginPage.dart';
import 'package:wormsup_dev/pages/widgets/alert.dart';
import 'package:wormsup_dev/pages/widgets/button.dart';
import 'package:wormsup_dev/pages/widgets/input_form.dart';

import '../../viewModel/register_view_model.dart';

class TokenPage extends StatefulWidget {
  final String username;
  final String email;
  final String password;

  const TokenPage({
    super.key,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  State<TokenPage> createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  final String tokenKode = 'Gx4K8dLpM2aR9tB1nC6eF5hJ3gV4qW2eR8';

  final TextEditingController _controllerToken = TextEditingController();

  void _cekToken() {
    if (_controllerToken.text.trim() == tokenKode) {
      RegisterViewModel().registerUser(
        username: widget.username.trim(),
        email: widget.email.trim(),
        password: widget.password.trim(),
      );

      _showDialogSucces("Token anda benar");
    } else {
      _showDialogFail("Token anda salah");
    }
  }

  void _showDialogSucces(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return SuccesAlertState(
          message: message,
          onPressed:
              () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ), // Ganti HomePage dengan halaman yang sesuai
                (Route<dynamic> route) => false,
              ),
        );
      },
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
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mohon masukkan token anda',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: 50),

                  InputFormNoIcon(
                    text: "Masukkan Token",
                    controller: _controllerToken,
                  ),

                  SizedBox(height: 20),

                  LongButton(
                    text: 'Konfirmasi',
                    color: "#6B4F3B",
                    colorText: "#FFFFFF",
                    onPressed: _cekToken,
                  ),
                ],
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
