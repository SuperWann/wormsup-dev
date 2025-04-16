import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  final String text;
  final String color;
  final String colorText;
  final VoidCallback onPressed;

  const LongButton({
    super.key,
    required this.text,
    required this.color,
    required this.colorText,
    required this.onPressed,
  });

  Color _hexToColor(String hexColor) {
    final hex = hexColor.replaceAll("#", "");
    return Color(int.parse("FF$hex", radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _hexToColor(color),
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: _hexToColor(colorText),
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
    );
  }
}

class ButtonDaftar extends StatelessWidget {
  const ButtonDaftar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ButtonGoogle extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ButtonGoogle({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Image.asset(
        'assets/images/google_logo.png', // pastikan ikon google ada
        height: 24,
      ),
      label: Text(
        text,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: const BorderSide(color: Color.fromARGB(255, 204, 204, 204)),
      ),
    );
  }
}
