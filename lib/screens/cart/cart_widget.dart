import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../../inner_screens/product_details.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final theme = utils.getTheme;
    final Color color = utils.color;
    Size size = utils.screenSize;
    return GestureDetector(
      onTap: () {
        GlobalMethods.navigateTo(context, ProductDetails.routeName);
      },
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    SizedBox(
                      height: size.width * .25,
                      width: size.width * .25,
                      child: FancyShimmerImage(
                        imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                        boxFit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Title',
                          color: color,
                          textSize: 18,
                          isTitle: true,
                        ),
                        SizedBox(
                          width: size.width * .3,
                          child: Row(
                            children: [
                              quantityController(
                                  onTap: () {
                                    if (_quantityTextController.text == '1') {
                                      return;
                                    } else {
                                      setState(() {
                                        _quantityTextController.text =
                                            (int.parse(_quantityTextController
                                                        .text) -
                                                    1)
                                                .toString();
                                      });
                                    }
                                  },
                                  icon: CupertinoIcons.minus,
                                  color: Colors.red),
                              Flexible(
                                flex: 2,
                                child: TextField(
                                  controller: _quantityTextController,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide())),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]'))
                                  ],
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      _quantityTextController.text = '1';
                                    }
                                  },
                                ),
                              ),
                              quantityController(
                                  onTap: () {
                                    setState(() {
                                      _quantityTextController.text = (int.parse(
                                                  _quantityTextController
                                                      .text) +
                                              1)
                                          .toString();
                                    });
                                  },
                                  icon: CupertinoIcons.plus,
                                  color: Colors.green),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          const InkWell(
                            child: Icon(
                              CupertinoIcons.cart_badge_minus,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const HeartBtn(),
                          TextWidget(
                            text: '\$0.29',
                            color: color,
                            textSize: 16,
                            maxLines: 1,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget quantityController(
      {required Function onTap, required IconData icon, required Color color}) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Material(
          borderRadius: BorderRadius.circular(12),
          color: color,
          child: InkWell(
            onTap: () {
              onTap();
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
