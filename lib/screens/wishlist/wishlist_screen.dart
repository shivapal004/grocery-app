import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';

  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final themeState = utils.getTheme;
    Size size = utils.screenSize;
    final Color color = utils.color;
    return  Scaffold(
      appBar: AppBar(
        title: TextWidget(
            text: "Cart (10)", color: utils.color, textSize: 20, isTitle: true),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(IconlyBroken.delete))
        ],
      ),
    );
  }
}
