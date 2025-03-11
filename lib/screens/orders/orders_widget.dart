import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../../services/utils.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({super.key});

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final theme = utils.getTheme;
    final Color color = utils.color;
    Size size = utils.screenSize;
    return ListTile(
      onTap: () {
        GlobalMethods.navigateTo(context, ProductDetails.routeName);
      },
      title: TextWidget(text: 'Title', color: color, textSize: 18),
      subtitle: const Text("Paid: \$12.8"),
      leading: FancyShimmerImage(
        imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
        boxFit: BoxFit.fill,
        width: size.width * .2,
      ),
      trailing: TextWidget(text: '11/02/2025', color: color, textSize: 14),
    );
  }
}
