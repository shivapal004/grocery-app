import 'package:flutter/material.dart';
import 'package:grocery_app/screens/orders/orders_widget.dart';
import 'package:provider/provider.dart';
import '../../provider/orders_provider.dart';
import '../../services/utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/empty_screen.dart';
import '../../widgets/text_widget.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/OrdersScreen';

  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final Color color = utils.color;
    final ordersProvider = Provider.of<OrdersProvider>(context);

    final ordersList = ordersProvider.getOrders;
    return FutureBuilder(
        future: ordersProvider.fetchOrders(),
        builder: (context, snapshot) {
          return ordersList.isEmpty
              ? const EmptyScreen(
                  title: "You didn't place any order yet",
                  subtitle: 'order something and make me happy :)',
                  buttonText: 'Shop now',
                  imagePath: 'assets/images/cart.png',
                )
              : Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    leading: const BackWidget(),
                    title: TextWidget(
                        text: "Your Orders (${ordersList.length})",
                        color: utils.color,
                        textSize: 20,
                        isTitle: true),
                  ),
                  body: ListView.separated(
                    itemCount: ordersList.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                          value: ordersList[index],
                          child: const OrdersWidget());
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: color,
                      );
                    },
                  ),
                );
        });
  }
}
