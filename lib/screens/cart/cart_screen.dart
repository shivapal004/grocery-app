import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/screens/cart/cart_widget.dart';
import 'package:grocery_app/widgets/empty_screen.dart';
import '../../inner_screens/product_details.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/text_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final Color color = utils.color;
    Size size = utils.screenSize;
    final themeState = utils.getTheme;
    FocusNode _focusNode = FocusNode();
    bool isEmpty = true;

    return isEmpty
        ? const EmptyScreen(
            title: 'Your cart is empty!',
            subtitle: 'Add something and make me happy',
            imagePath: 'assets/images/cart.png',
            buttonText: 'Shop now.',
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: const BackWidget(),
              title: TextWidget(
                  text: "Cart (10)",
                  color: utils.color,
                  textSize: 20,
                  isTitle: true),
              actions: [
                IconButton(
                    onPressed: () {
                      GlobalMethods.warningDialog(
                          title: 'Empty you cart',
                          subtitle: 'Are you sure?',
                          function: () {},
                          context: context);
                    },
                    icon: const Icon(IconlyBroken.delete))
              ],
            ),
            body: Column(
              children: [
                _checkout(context: context),
                Expanded(
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (ctx, index) {
                        return const CartWidget();
                      }),
                ),
              ],
            ),
          );
  }

  Widget _checkout({required BuildContext context}) {
    Utils utils = Utils(context);
    final themeState = utils.getTheme;
    Size size = utils.screenSize;
    final Color color = utils.color;
    return SizedBox(
      width: double.infinity,
      height: size.height * .1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Material(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () {
                  GlobalMethods.navigateTo(context, ProductDetails.routeName);
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                      text: 'Order now', color: Colors.white, textSize: 20),
                ),
              ),
            ),
            const Spacer(),
            TextWidget(
              text: 'Total: \$0.259',
              color: color,
              textSize: 18,
              isTitle: true,
            )
          ],
        ),
      ),
    );
  }
}
