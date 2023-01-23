import 'package:flutter/material.dart';

class emButton extends StatelessWidget {
  const emButton(
      {super.key,
      required this.color,
      required this.title,
      required this.onPressed});

  final Color color;
  final String title;
  final VoidCallback onPressed; // غيرت هنا عشان يضبط البتن وبربطها بالصفحات

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(300),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 300,
          height: 300,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}