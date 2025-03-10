import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/feed_screen.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/feed_widget.dart';
import 'package:grocery_app/widgets/on_sale_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _offerImages = [
    "assets/images/offers/Offer1.jpg",
    "assets/images/offers/Offer2.jpg",
    "assets/images/offers/Offer3.jpg",
    "assets/images/offers/Offer4.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final themeState = utils.getTheme;
    Size size = utils.screenSize;
    final Color color = utils.color;

    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
            text: "Home Screen",
            color: utils.color,
            textSize: 20,
            isTitle: true),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * .33,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    _offerImages[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: _offerImages.length,
                pagination: const SwiperPagination(
                    // alignment: Alignment.bottomCenter,
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
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return const OnSaleWidget();
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
              children: List.generate(10, (index) {
                return const FeedWidget();
              }),
            )
          ],
        ),
      ),
    );
  }
}
