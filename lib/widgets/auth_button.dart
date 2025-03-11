import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {super.key,
      required this.function,
      required this.buttonText,
      this.color = Colors.white38});

  final Function function;
  final String buttonText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {
            function();
          },
          child:
              TextWidget(text: buttonText, color: Colors.white, textSize: 18)),
    );
  }
}
