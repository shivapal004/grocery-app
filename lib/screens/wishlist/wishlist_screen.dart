import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/screens/wishlist/wishlist_widget.dart';
import 'package:grocery_app/widgets/back_widget.dart';

import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';

  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final themeState = utils.getTheme;
    Size size = utils.screenSize;
    final Color color = utils.color;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackWidget(),
        title: TextWidget(
            text: "Wishlist (10)",
            color: utils.color,
            textSize: 20,
            isTitle: true),
        actions: [
          IconButton(onPressed: () {
            GlobalMethods.warningDialog(
                title: 'Empty you wishlist',
                subtitle: 'Are you sure?',
                function: () {},
                context: context);
          }, icon: const Icon(IconlyBroken.delete))
        ],
      ),
      body: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemBuilder: (context, index) {
            return const WishlistWidget();
          }),
    );
  }
}
