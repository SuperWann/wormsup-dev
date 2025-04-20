import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wormsup_dev/pages/auth/authPage.dart';
import 'package:wormsup_dev/pages/widgets/button.dart';

class SuccesAlertState extends StatelessWidget {
  const SuccesAlertState({
    super.key,
    required this.message,
    required this.onPressed,
  });

  final String message;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Berhasil",
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.green,
        ),
      ),
      content: SizedBox(
        height: 180,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset('assets/images/succes.png', width: 80),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: TextButton(child: Text('OK'), onPressed: onPressed),
        ),
      ],
    );
  }
}

class FailAlertState extends StatelessWidget {
  const FailAlertState({
    super.key,
    required this.message,
    required this.onPressed,
  });

  final String message;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Gagal",
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.red,
        ),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 180,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset('assets/images/fail.png', width: 80),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: [
        Container(
          // margin: const EdgeInsets.only(left: 5, right: 5),
          child: LongButton(
            text: "OK",
            color: "#FF0000",
            colorText: "#FFFFFF",
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}

class ConfirmLogout extends StatelessWidget {
  final String message;

  const ConfirmLogout({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        "Konfirmasi",
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 60,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),

      actions: [
        LongButton(
          text: "Iya",
          color: "#6B4F3B",
          colorText: "#FFFFFF",
          onPressed: () async {
            // Tampilkan dialog loading
            showDialog(
              context: context,
              barrierDismissible: false, // Supaya tidak bisa ditutup manual
              builder: (context) {
                return const Center(child: CircularProgressIndicator());
              },
            );
            await Future.delayed(const Duration(seconds: 2));
            await FirebaseAuth.instance.signOut();
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
            // Arahkan ke AuthPage
            Navigator.pushAndRemoveUntil(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(builder: (context) => const AuthPage()),
              (Route<dynamic> route) => false,
            );
          },
        ),

        SizedBox(height: 10),
        LongButton(
          text: "Tidak",
          color: "#FFFFFF",
          colorText: "#6B4F3B",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
