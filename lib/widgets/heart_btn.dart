import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';

class HeartBtn extends StatelessWidget {
  const HeartBtn(
      {super.key, required this.productId, required this.isInWishlist});

  final String productId;
  final bool? isInWishlist;

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    Utils utils = Utils(context);
    final Color color = utils.color;
    return GestureDetector(
        onTap: () {
          final User? user = auth.currentUser;
          if (user == null) {
            GlobalMethods.errorDialog(
                subtitle: "No user found, please login first", context: context);
          }
          wishlistProvider.addRemoveProductToWishList(productId: productId);
        },
        child: Icon(
          isInWishlist != null && isInWishlist == true
              ? IconlyBold.heart
              : IconlyLight.heart,
          color:
          isInWishlist != null && isInWishlist == true ? Colors.red : color,
          size: 22,
        ));
  }
}
