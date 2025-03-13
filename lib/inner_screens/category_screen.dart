import 'package:flutter/material.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/provider/product_provider.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_product_widget.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';
import '../widgets/feed_widget.dart';
import '../widgets/text_widget.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = '/feedScreen';

  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final Color color = utils.color;
    Size size = utils.screenSize;
    final productProvider = Provider.of<ProductProvider>(context);
    final categoryName = ModalRoute.of(context)!.settings.arguments as String;
    List<ProductModel> productByCategory =
        productProvider.findByCategory(categoryName);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackWidget(),
        title: TextWidget(
          text: 'All Products',
          color: color,
          textSize: 20,
          isTitle: true,
        ),
      ),
      body: productByCategory.isEmpty
          ? const EmptyProductWidget(
        text: 'No product belong to this category',
      )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: kBottomNavigationBarHeight,
                      child: TextField(
                        focusNode: _searchTextFocusNode,
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.greenAccent, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.greenAccent, width: 2)),
                            hintText: "What's on your mind",
                            prefixIcon: const Icon(Icons.search),
                            suffix: IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  _searchTextFocusNode.unfocus();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: _searchTextFocusNode.hasFocus
                                      ? Colors.red
                                      : color,
                                ))),
                      ),
                    ),
                  ),
                  GridView.count(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: size.width / (size.height * .55),
                    crossAxisCount: 2,
                    children: List.generate(productByCategory.length, (index) {
                      return ChangeNotifierProvider.value(
                        value: productByCategory[index],
                        child: const FeedWidget(),
                      );
                    }),
                  ),
                ],
              ),
            ),
    );
  }
}
