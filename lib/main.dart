import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/inner_screens/feed_screen.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/provider/product_provider.dart';
import 'package:grocery_app/screens/auth/forgot_password_screen.dart';
import 'package:grocery_app/screens/auth/login_screen.dart';
import 'package:grocery_app/screens/auth/register_screen.dart';
import 'package:grocery_app/screens/bottom_bar_screen.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/orders/orders_screen.dart';
import 'package:grocery_app/screens/viewed_recently/viewed_screen.dart';
import 'package:grocery_app/screens/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';
import 'inner_screens/category_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentThemeApp() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentThemeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        }),
        ChangeNotifierProvider(create: (_) {
          return ProductProvider();
        }),
        ChangeNotifierProvider(create: (_) {
          return CartProvider();
        }),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: const BottomBarScreen(),
            routes: {
              HomeScreen.routeName: (ctx) => const HomeScreen(),
              OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
              FeedScreen.routeName: (ctx) => const FeedScreen(),
              ProductDetails.routeName: (ctx) => const ProductDetails(),
              WishlistScreen.routeName: (ctx) => const WishlistScreen(),
              OrdersScreen.routeName: (ctx) => const OrdersScreen(),
              ViewedScreen.routeName: (ctx) => const ViewedScreen(),
              LoginScreen.routeName: (ctx) => const LoginScreen(),
              RegisterScreen.routeName: (ctx) => const RegisterScreen(),
              ForgotPasswordScreen.routeName: (ctx) => const ForgotPasswordScreen(),
              BottomBarScreen.routeName: (ctx) => const BottomBarScreen(),
              CategoryScreen.routeName: (ctx) => const CategoryScreen()
            },
          );
        },
      ),
    );
  }
}
