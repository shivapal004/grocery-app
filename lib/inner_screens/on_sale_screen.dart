import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_product_widget.dart';
import 'package:grocery_app/widgets/on_sale_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../provider/product_provider.dart';
import '../services/utils.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = '/onSaleScreen';

  const OnSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final Color color = utils.color;
    Size size = utils.screenSize;
    final productProvider = Provider.of<ProductProvider>(context);
    List<ProductModel> productOnSale = productProvider.getProducts;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const BackWidget(),
        title: TextWidget(
          text: 'Products on sale',
          color: color,
          textSize: 20,
          isTitle: true,
        ),
      ),
      body: productOnSale.isEmpty
          ? const EmptyProductWidget(
              text: 'No product on sale yet!, \nStay tuned',
            )
          : GridView.count(
              padding: EdgeInsets.zero,
              childAspectRatio: size.width / (size.height * .45),
              crossAxisCount: 2,
              children: List.generate(productOnSale.length, (index) {
                return ChangeNotifierProvider.value(
                    value: productOnSale[index], child: const OnSaleWidget());
              }),
            ),
    );
  }
}
