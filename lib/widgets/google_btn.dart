import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class GoogleBtn extends StatelessWidget {
  const GoogleBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),

                child: Image.asset(
                  'assets/images/google.png',
                  width: 40,
                )),
            const SizedBox(
              width: 5,
            ),
            TextWidget(
                text: 'Sign in with google', color: Colors.white, textSize: 18),
          ],
        ),
      ),
    );
  }
}
