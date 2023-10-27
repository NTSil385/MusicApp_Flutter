import 'package:flutter/material.dart';

class ButtonOutlineWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClick;

  const ButtonOutlineWidget({super.key, required this.text, required this.onClick});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff1d2846),
          side: const BorderSide(color: Colors.white, width: 3),
          padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ));
  }
}
