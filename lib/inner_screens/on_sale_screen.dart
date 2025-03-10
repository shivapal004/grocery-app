import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/widgets/on_sale_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../services/utils.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = '/onSaleScreen';

  const OnSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final theme = utils.getTheme;
    final Color color = utils.color;
    Size size = utils.screenSize;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            borderRadius: BorderRadius.circular(12),
            child: const Icon(IconlyLight.arrowLeft2)),
        title: TextWidget(
          text: 'Products on sale',
          color: color,
          textSize: 20,
          isTitle: true,
        ),
      ),
      body: GridView.count(
        padding: EdgeInsets.zero,
        childAspectRatio: size.width / (size.height * .45),
        crossAxisCount: 2,
        children: List.generate(10, (index) {
          return const OnSaleWidget();
        }),
      ),
    );
  }
}
