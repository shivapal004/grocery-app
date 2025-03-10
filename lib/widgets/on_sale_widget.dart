import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

import '../inner_screens/product_details.dart';
import '../services/global_methods.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({super.key});

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final theme = utils.getTheme;
    final Color color = utils.color;
    Size size = utils.screenSize;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        // color: Theme.of(context).cardColor.withOpacity(0.9),
        color: Colors.blueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: (){
            GlobalMethods.navigateTo(context, ProductDetails.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FancyShimmerImage(
                      imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                      height: size.width * .22,
                      width: size.width * .22,
                      boxFit: BoxFit.fill,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        TextWidget(
                          text: '1KG',
                          color: color,
                          textSize: 22,
                          isTitle: true,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  IconlyLight.bag2,
                                  color: color,
                                  size: 22,
                                )),
                            const HeartBtn(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const PriceWidget(
                  salePrice: 2.99,
                  price: 5.9,
                  textPrice: '1',
                  isOnSale: true,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                  text: 'Product title',
                  color: color,
                  textSize: 16,
                  isTitle: true,
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
