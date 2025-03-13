import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';

class FeedWidget extends StatefulWidget {
  const FeedWidget({
    super.key,
  });

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  final _quantityTextController = TextEditingController();
  final FocusNode _quantityTextFocusNode = FocusNode();

  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    _quantityTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final Color color = utils.color;
    Size size = utils.screenSize;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blueAccent.withOpacity(0.1),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id);
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              FancyShimmerImage(
                imageUrl: productModel.imageUrl,
                height: size.width * .21,
                width: size.width * .2,
                boxFit: BoxFit.fill,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: TextWidget(
                        text: productModel.title,
                        color: color,
                        maxLines: 1,
                        textSize: 18,
                        isTitle: true,
                      ),
                    ),
                    const Flexible(
                      flex: 1,
                      child: HeartBtn(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: PriceWidget(
                        salePrice: productModel.salePrice,
                        price: productModel.price,
                        textPrice: _quantityTextController.text,
                        isOnSale: productModel.isOnSale,
                      ),
                    ),
                    // const SizedBox(
                    //   width: 5,
                    // ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            flex: 6,
                            child: FittedBox(
                                child: TextWidget(
                              text: productModel.isPiece ? 'piece' : 'KG',
                              color: color,
                              textSize: 16,
                              isTitle: true,
                            )),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('1')
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: isInCart
                      ? null
                      : () {
                          cartProvider.addProductToCart(
                              productId: productModel.id,
                              quantity:
                                  int.parse(_quantityTextController.text));
                        },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).cardColor),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12.0),
                            bottomRight: Radius.circular(12.0),
                          ),
                        ),
                      )),
                  child: TextWidget(
                    text: isInCart ? 'In cart' : 'Add to cart',
                    color: color,
                    textSize: 18,
                    isTitle: true,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
