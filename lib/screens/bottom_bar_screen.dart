import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/screens/categories_screen.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/user_screen.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../widgets/text_widget.dart';
import 'cart/cart_screen.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';

  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _pages = [
    {'page': const HomeScreen(), 'title': const Text("Home Screen")},
    {'page': CategoriesScreen(), 'title': const Text("Category Screen")},
    {'page': const CartScreen(), 'title': const Text("Cart Screen")},
    {'page': const UserScreen(), 'title': const Text("User Screen")}
  ];

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool isDark = themeState.getDarkTheme;
    return Scaffold(
      // appBar: AppBar(
      //   title: _pages[_selectedIndex]['title'],
      // ),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: isDark ? Theme.of(context).cardColor : Colors.white,
          selectedItemColor:
              isDark ? Colors.lightBlue.shade200 : Colors.black87,
          unselectedItemColor: isDark ? Colors.white : Colors.black54,
          onTap: _selectedPage,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(_selectedIndex == 1
                    ? IconlyBold.category
                    : IconlyLight.category),
                label: "Category"),
            BottomNavigationBarItem(
                icon: Consumer<CartProvider>(
                  builder: (_, myCart, ch) {
                    return badges.Badge(
                      // toAnimate: true,
                      badgeStyle:  badges.BadgeStyle(
                        shape: badges.BadgeShape.circle,
                        badgeColor: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      position: badges.BadgePosition.topEnd(top: -7, end: -7),
                      badgeContent: FittedBox(
                          child: TextWidget(
                              text: myCart.getCartItems.length.toString(),
                              color: Colors.white,
                              textSize: 10)),
                      child: Icon(_selectedIndex == 2
                          ? IconlyBold.buy
                          : IconlyLight.buy),
                    );
                  },
                ),
                label: "Cart"),
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
                label: "User"),
          ]),
    );
  }
}
