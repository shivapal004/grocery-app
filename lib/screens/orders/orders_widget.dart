import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/models/orders_model.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../provider/orders_provider.dart';
import '../../provider/product_provider.dart';
import '../../services/utils.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({super.key});

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  late String orderDateToShow;

  @override
  void didChangeDependencies() {
    final orderModel = Provider.of<OrderModel>(context);
    var orderDate = orderModel.orderDate.toDate();
    orderDateToShow = '${orderDate.day}/${orderDate.month}/${orderDate.year}';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final Color color = utils.color;
    Size size = utils.screenSize;
    final orderModel = Provider.of<OrderModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrentProduct = productProvider.findProdById(orderModel.productId);
    return ListTile(
      onTap: () {
        GlobalMethods.navigateTo(context, ProductDetails.routeName);
      },
      title: TextWidget(text: '${getCurrentProduct.title}   x${orderModel.quantity}', color: color, textSize: 18),
      subtitle:  Text("Paid: \$${double.parse(orderModel.price).toStringAsFixed(2)}"),
      leading: FancyShimmerImage(
        imageUrl: orderModel.imageUrl,
        boxFit: BoxFit.fill,
        width: size.width * .2,
      ),
      trailing: TextWidget(text: orderDateToShow, color: color, textSize: 14),
    );
  }
}
