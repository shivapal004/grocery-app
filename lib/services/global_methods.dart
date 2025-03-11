import 'package:flutter/material.dart';

import '../widgets/text_widget.dart';

class GlobalMethods {
  static navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  static Future<void> warningDialog(
      {required String title,
      required String subtitle,
      required Function function,
      required BuildContext context}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/warning-sign.png',
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                ),
                const SizedBox(width: 5),
                Text(title)
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: TextWidget(
                      text: 'Cancel', color: Colors.cyan, textSize: 18)),
              TextButton(
                  onPressed: () {
                    function();
                  },
                  child:
                      TextWidget(text: 'Ok', color: Colors.red, textSize: 18))
            ],
          );
        });
  }
}
