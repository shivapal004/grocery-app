import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../services/utils.dart';

class HeartBtn extends StatelessWidget {
  const HeartBtn({super.key});

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final Color color = utils.color;
    return GestureDetector(
        onTap: () {},
        child: Icon(
          IconlyLight.heart,
          color: color,
          size: 22,
        ));
  }
}
