import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../../services/utils.dart';

class WishlistWidget extends StatefulWidget {
  const WishlistWidget({super.key});

  @override
  State<WishlistWidget> createState() => _WishlistWidgetState();
}

class _WishlistWidgetState extends State<WishlistWidget> {
  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final theme = utils.getTheme;
    final Color color = utils.color;
    Size size = utils.screenSize;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          GlobalMethods.navigateTo(context, ProductDetails.routeName);
        },
        child: Container(
          height: size.height * .16,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color, width: 0.5),
              color: Theme.of(context).cardColor),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 8),
                height: size.width * 0.2,
                width: size.width * .25,
                child: FancyShimmerImage(
                  imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                  boxFit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Flexible(
                      child: Row(
                        children: [Icon(IconlyLight.bag2), HeartBtn()],
                      ),
                    ),
                    Flexible(
                      child: TextWidget(
                        text: 'Title',
                        color: color,
                        textSize: 20,
                        isTitle: true,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Flexible(
                      child: TextWidget(
                        text: '\$2.59',
                        color: color,
                        textSize: 18,
                        isTitle: true,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
