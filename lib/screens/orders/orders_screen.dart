import 'package:flutter/material.dart';
import 'package:grocery_app/screens/orders/orders_widget.dart';
import '../../services/utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/text_widget.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/OrdersScreen';
  const OrdersScreen({super.key});

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
            text: "Your Orders (10)",
            color: utils.color,
            textSize: 20,
            isTitle: true),
      ),
      body: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const OrdersWidget();
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: color,
          );
        },
      ),
    );
  }
}
