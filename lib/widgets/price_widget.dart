import 'package:flutter/material.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget(
      {super.key,
      required this.salePrice,
      required this.price,
      required this.textPrice,
      required this.isOnSale});

  final double salePrice, price;
  final String textPrice;
  final bool isOnSale;

  @override
  Widget build(BuildContext context) {
    double userPrice = isOnSale ? salePrice : price;
    final Color color = Utils(context).color;
    return FittedBox(
      child: Row(
        children: [
          TextWidget(
              text:
                  '\$${(userPrice * int.parse(textPrice)).toStringAsFixed(2)}',
              color: Colors.green,
              textSize: 20),
          const SizedBox(
            width: 5,
          ),
          Visibility(
            visible: isOnSale ? true : false,
            child: Text(
              '\$${(price * int.parse(textPrice)).toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 16,
                  color: color,
                  decoration: TextDecoration.lineThrough),
            ),
          )
        ],
      ),
    );
  }
}
