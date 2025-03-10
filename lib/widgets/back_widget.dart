import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../services/utils.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final Color color = utils.color;
    return InkWell(
        onTap: () {
          Navigator.canPop(context) ? Navigator.pop(context) : null;
        },
        child: Icon(
          IconlyLight.arrowLeft2,
          color: color,
        ));
  }
}
