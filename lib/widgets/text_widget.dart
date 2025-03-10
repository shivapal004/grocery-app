import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  TextWidget(
      {super.key,
      required this.text,
      required this.color,
      required this.textSize,
      this.isTitle = false,
      this.maxLines = 10});

  final String text;
  final Color color;
  final double textSize;
  bool isTitle;
  int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color,
          fontSize: textSize,
          fontWeight: isTitle ? FontWeight.w700 : FontWeight.normal),
    );
  }
}
