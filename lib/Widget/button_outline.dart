import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonOutlineWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClick;

  const ButtonOutlineWidget({super.key, required this.text, required this.onClick});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff1d2846),
          side: BorderSide(color: Colors.white, width: 3),
          padding: EdgeInsets.symmetric(horizontal: 140, vertical: 22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          '$text',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ));
  }
}
