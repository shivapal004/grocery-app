import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/screens/wishlist/wishlist_widget.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_screen.dart';
import 'package:provider/provider.dart';

import '../../provider/wishlist_provider.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';

  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemList =
        wishlistProvider.getWishlistItems.values.toList().reversed.toList();
    return wishlistItemList.isEmpty
        ? const EmptyScreen(
            title: 'Your wishlist is empty',
            subtitle: 'Explore more and shortlist some items',
            imagePath: 'assets/images/wishlist.png',
            buttonText: 'Add a wish')
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: const BackWidget(),
              title: TextWidget(
                  text: "Wishlist (${wishlistItemList.length})",
                  color: utils.color,
                  textSize: 20,
                  isTitle: true),
              actions: [
                IconButton(
                    onPressed: () {
                      GlobalMethods.warningDialog(
                          title: 'Empty you wishlist',
                          subtitle: 'Are you sure?',
                          function: () {
                            wishlistProvider.clearWishlist();
                          },
                          context: context);
                    },
                    icon: const Icon(IconlyBroken.delete))
              ],
            ),
            body: MasonryGridView.count(
                itemCount: wishlistItemList.length,
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                      value: wishlistItemList[index],
                      child: const WishlistWidget());
                }),
          );
  }
}
