import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/feed_screen.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/feed_widget.dart';
import 'package:grocery_app/widgets/on_sale_widget.dart';
import 'package:provider/provider.dart';
import '../consts/consts.dart';
import '../models/product_model.dart';
import '../provider/product_provider.dart';
import '../widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final themeState = utils.getTheme;
    Size size = utils.screenSize;
    final Color color = utils.color;
    final productProvider = Provider.of<ProductProvider>(context);
    List<ProductModel> allProducts = productProvider.getProducts;
    List<ProductModel> productOnSale = productProvider.getOnSaleProducts;

    return Scaffold(
      // appBar: AppBar(
      //   title: TextWidget(
      //       text: "Home Screen",
      //       color: utils.color,
      //       textSize: 20,
      //       isTitle: true),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * .33,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    Consts.offerImages[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: Consts.offerImages.length,
                pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                        color: Colors.white, activeColor: Colors.red)),
                control: const SwiperControl(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                GlobalMethods.navigateTo(context, OnSaleScreen.routeName);
              },
              child: TextWidget(
                text: 'View all',
                color: Colors.blue,
                textSize: 18,
                isTitle: true,
                maxLines: 1,
              ),
            ),
            Row(
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Row(
                    children: [
                      TextWidget(
                        text: 'ON SALE',
                        color: Colors.red,
                        textSize: 20,
                        isTitle: true,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(IconlyLight.discount)
                    ],
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    height: size.height * .22,
                    child: ListView.builder(
                        itemCount: productOnSale.length < 10
                            ? productOnSale.length
                            : 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return ChangeNotifierProvider.value(
                              value: productOnSale[index],
                              child: const OnSaleWidget());
                        }),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Our Products',
                    color: color,
                    textSize: 18,
                    isTitle: true,
                  ),
                  TextButton(
                    onPressed: () {
                      GlobalMethods.navigateTo(context, FeedScreen.routeName);
                    },
                    child: TextWidget(
                      text: 'Browse all',
                      color: Colors.blue,
                      textSize: 18,
                      isTitle: true,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              childAspectRatio: size.width / (size.height * .55),
              crossAxisCount: 2,
              children: List.generate(
                  allProducts.length < 4 ? allProducts.length : 4, (index) {
                return ChangeNotifierProvider.value(
                  value: allProducts[index],
                  child: const FeedWidget(),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
