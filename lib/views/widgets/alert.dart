import 'package:flutter/material.dart';
import 'package:wormsup_dev/views/widgets/button.dart';

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

class Confirm extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;
  final double height;

  const Confirm({super.key, required this.message, required this.onPressed, required this.height});

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
        height: height,
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
          onPressed: onPressed,
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
