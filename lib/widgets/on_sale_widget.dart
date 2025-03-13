import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:provider/provider.dart';

import '../inner_screens/product_details.dart';
import '../models/product_model.dart';
import '../provider/cart_provider.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({super.key});

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final Color color = utils.color;
    Size size = utils.screenSize;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        // color: Theme.of(context).cardColor.withOpacity(0.9),
        color: Colors.blueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: (){
            Navigator.pushNamed(context, ProductDetails.routeName, arguments: productModel.id);
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
                      imageUrl: productModel.imageUrl,
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
                          text: productModel.isPiece ? '1Piece' : '1KG',
                          color: color,
                          textSize: 22,
                          isTitle: true,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  cartProvider.addProductToCart(
                                      productId: productModel.id,
                                      quantity: 1);
                                },
                                child: Icon(
                                  isInCart? IconlyBold.bag2 : IconlyLight.bag2,
                                  color: isInCart ? Colors.green : color,
                                  size: 22,
                                )),
                            const HeartBtn(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                 PriceWidget(
                  salePrice: productModel.salePrice,
                  price: productModel.price,
                  textPrice: '1',
                  isOnSale: true,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                  text: productModel.title,
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
