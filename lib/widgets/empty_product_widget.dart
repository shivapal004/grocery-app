import 'package:flutter/material.dart';

import '../services/utils.dart';

class EmptyProductWidget extends StatelessWidget {
  const EmptyProductWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final Color color = utils.color;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/box.jfif'),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: color,
                  fontSize: 30,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
