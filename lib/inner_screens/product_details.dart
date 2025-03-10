import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../services/global_methods.dart';
import '../services/utils.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/productDetailsScreen';

  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _quantityTextController = TextEditingController(text: '1');
  FocusNode _focusNode = FocusNode();


  @override
  void dispose() {
    _quantityTextController.dispose();
    _focusNode.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final theme = utils.getTheme;
    final Color color = utils.color;
    Size size = utils.screenSize;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              child: Icon(
                IconlyLight.arrowLeft2,
                color: color,
              )),
        ),
        body: Column(
          children: [
            Flexible(
              flex: 2,
              child: FancyShimmerImage(
                imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                boxFit: BoxFit.scaleDown,
                width: size.width,
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TextWidget(
                              text: 'title',
                              color: color,
                              textSize: 20,
                              isTitle: true,
                            ),
                          ),
                          const HeartBtn()
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextWidget(
                            text: '\$2.59',
                            color: Colors.green,
                            textSize: 20,
                            isTitle: true,
                          ),
                          TextWidget(
                            text: '/KG',
                            color: color,
                            textSize: 12,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Visibility(
                            visible: true,
                            child: Text(
                              '\$3.9',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: color,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: const BoxDecoration(color: Colors.green),
                            child: TextWidget(
                              text: 'Free delivery',
                              color: Colors.white,
                              textSize: 20,
                              isTitle: true,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                            icon: CupertinoIcons.minus_square,
                            color: Colors.red),
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: _quantityTextController,
                            focusNode: _focusNode,
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide())),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9]'))
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
                                _quantityTextController.text =
                                    (int.parse(_quantityTextController
                                        .text) +
                                        1)
                                        .toString();
                              });
                            },
                            icon: CupertinoIcons.plus_square,
                            color: Colors.green),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: 'Total',
                                color: Colors.red.shade300,
                                textSize: 20,
                                isTitle: true,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              FittedBox(
                                child: Row(
                                  children: [
                                    TextWidget(
                                      text: '\$2.59/',
                                      color: color,
                                      textSize: 20,
                                      isTitle: true,
                                    ),
                                    TextWidget(
                                      text: '${_quantityTextController.text}KG',
                                      color: color,
                                      textSize: 16,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                          Material(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              // onTap: (){
                              //   GlobalMethods.navigateTo(context, ProductDetails.routeName);
                              // },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextWidget(
                                    text: 'Add to cart',
                                    color: Colors.white,
                                    textSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
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
