import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/screens/auth/forgot_password_screen.dart';
import 'package:grocery_app/screens/auth/login_screen.dart';
import 'package:grocery_app/screens/orders/orders_screen.dart';
import 'package:grocery_app/screens/viewed_recently/viewed_screen.dart';
import 'package:grocery_app/screens/wishlist/wishlist_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../consts/firebase_consts.dart';
import '../services/utils.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressController =
      TextEditingController(text: '');

  User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  String? email;
  String? name;
  String? address;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      isLoading = true;
    });
    if (user == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    try {
      String uid = user!.uid;
      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      email = userDoc.get('email');
      name = userDoc.get('name');
      address = userDoc.get('shipping-address');
      _addressController.text = userDoc.get('shipping-address');
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final Color color = utils.color;
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
            text: "User Screen",
            color: utils.color,
            textSize: 20,
            isTitle: true),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(
                      text: "Hi,  ",
                      style: const TextStyle(
                          color: Colors.cyan,
                          fontSize: 26,
                          fontWeight: FontWeight.w600),
                      children: [
                    TextSpan(
                        text: name ?? 'user',
                        style: TextStyle(
                            color: color,
                            fontSize: 26,
                            fontWeight: FontWeight.w500),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("Name is pressed");
                          })
                  ])),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                  text: email ?? 'user@gmail.com', color: color, textSize: 18),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                thickness: 2,
              ),
              _listTiles(
                  title: 'Address',
                  subtitle: address,
                  color: color,
                  icon: IconlyLight.profile,
                  onPressed: () {
                    _showAddressDialog();
                  }),
              _listTiles(
                  title: 'Orders',
                  subtitle: 'Check your order history',
                  color: color,
                  icon: IconlyLight.bag,
                  onPressed: () {
                    GlobalMethods.navigateTo(context, OrdersScreen.routeName);
                  }),
              _listTiles(
                  title: 'Wishlist',
                  subtitle: 'View your saved items',
                  color: color,
                  icon: IconlyLight.heart,
                  onPressed: () {
                    Navigator.pushNamed(context, WishlistScreen.routeName);
                  }),
              _listTiles(
                  title: 'Viewed',
                  subtitle: 'See recently viewed items',
                  color: color,
                  icon: IconlyLight.show,
                  onPressed: () {
                    Navigator.pushNamed(context, ViewedScreen.routeName);
                  }),
              _listTiles(
                  title: 'Forget password',
                  subtitle: 'Reset your password',
                  color: color,
                  icon: IconlyLight.unlock,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen()));
                  }),
              _listTiles(
                  title: user == null ? 'Login' : 'Logout',
                  subtitle: user == null
                      ? 'Sign in to your account'
                      : 'Sign out of your account',
                  color: color,
                  icon: user == null ? IconlyLight.login : IconlyLight.logout,
                  onPressed: () {
                    if (user == null) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                      return;
                    }
                    GlobalMethods.warningDialog(
                        title: 'Sign out',
                        subtitle: 'Do you want to sign out?',
                        function: () async {
                          await auth.signOut();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                        },
                        context: context);
                  }),
              SwitchListTile(
                  title: TextWidget(
                    text: "Dark Mode",
                    color: color,
                    textSize: 20,
                    isTitle: true,
                  ),
                  secondary: Icon(
                    themeState.getDarkTheme
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                    color: color,
                  ),
                  value: themeState.getDarkTheme,
                  onChanged: (bool value) {
                    setState(() {
                      themeState.setDarkTheme = value;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update"),
            content: TextField(
              controller: _addressController,
              decoration: const InputDecoration(hintText: "Your Address"),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  String uid = user!.uid;

                  try {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .update({'shipping-address': _addressController.text});
                    Navigator.pop(context);
                    setState(() {
                      address = _addressController.text;
                    });
                  } catch (error) {
                    GlobalMethods.errorDialog(
                        subtitle: error.toString(), context: context);
                  }
                },
                child: const Text("Update"),
              ),
            ],
          );
        });
  }

  Widget _listTiles(
      {required String title,
      String? subtitle,
      required IconData icon,
      required Function onPressed,
      required Color color}) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 18,
        isTitle: true,
      ),
      subtitle: TextWidget(text: subtitle ?? "", color: color, textSize: 13),
      leading: Icon(
        icon,
        color: color,
      ),
      trailing: Icon(
        IconlyLight.arrowRight2,
        color: color,
      ),
      onTap: () {
        onPressed();
      },
    );
  }
}
