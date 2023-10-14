import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClick;

  const ButtonWidget({super.key, required this.text, required this.onClick});
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 140, vertical: 22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          '$text',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ));
  }
}
