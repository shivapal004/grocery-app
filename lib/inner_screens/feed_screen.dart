import 'package:flutter/material.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/provider/product_provider.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:provider/provider.dart';
import '../services/utils.dart';
import '../widgets/empty_product_widget.dart';
import '../widgets/feed_widget.dart';
import '../widgets/text_widget.dart';

class FeedScreen extends StatefulWidget {
  static const routeName = '/FeedScreen';

  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  List<ProductModel> productSearchList = [];

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
    List<ProductModel> allProducts = productProvider.getProducts;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const BackWidget(),
        title: TextWidget(
          text: 'All Products',
          color: color,
          textSize: 20,
          isTitle: true,
        ),
      ),
      body: SingleChildScrollView(
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
                    setState(() {
                      productSearchList = productProvider.searchQuery(value);
                    });
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
            _searchController.text.isNotEmpty && productSearchList.isEmpty
                ? const EmptyProductWidget(
                    text: 'No product found, please try another keyword')
                : GridView.count(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: size.width / (size.height * .55),
                    crossAxisCount: 2,
                    children: List.generate(
                        _searchController.text.isNotEmpty
                            ? productSearchList.length
                            : allProducts.length, (index) {
                      return ChangeNotifierProvider.value(
                        value: _searchController.text.isNotEmpty
                            ? productSearchList[index]
                            : allProducts[index],
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
