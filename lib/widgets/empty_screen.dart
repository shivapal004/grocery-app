import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/feed_screen.dart';
import 'package:grocery_app/screens/bottom_bar_screen.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../services/utils.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.imagePath,
      required this.buttonText});

  final String title, subtitle, imagePath, buttonText;

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final Color color = utils.color;
    Size size = utils.screenSize;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: size.width,
              height: size.height * .4,
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Whoops!',
              style: TextStyle(
                  color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TextWidget(
                text: title,
                color: Colors.cyan,
                textSize: 20),
            TextWidget(
                text: subtitle,
                color: Colors.cyan,
                textSize: 20),
            const SizedBox(
              height: 80,
            ),
            ElevatedButton(
                onPressed: () {
                  GlobalMethods.navigateTo(context, FeedScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: color),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.secondary),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                    text: buttonText,
                    color: Colors.grey.shade800,
                    textSize: 20,
                    isTitle: true,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
