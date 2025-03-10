import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
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
                        text: "User",
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
              TextWidget(text: "user@gmail.com", color: color, textSize: 18),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                thickness: 2,
              ),
              _listTiles(
                  title: 'Address',
                  subtitle: 'subtitle',
                  color: color,
                  icon: IconlyLight.profile,
                  onPressed: () {
                    _showAddressDialog();
                  }),
              _listTiles(
                  title: 'Orders',
                  color: color,
                  icon: IconlyLight.bag,
                  onPressed: () {}),
              _listTiles(
                  title: 'Wishlist',
                  color: color,
                  icon: IconlyLight.heart,
                  onPressed: () {}),
              _listTiles(
                  title: 'Viewed',
                  color: color,
                  icon: IconlyLight.show,
                  onPressed: () {}),
              _listTiles(
                  title: 'Forget password',
                  color: color,
                  icon: IconlyLight.unlock,
                  onPressed: () {}),
              // SwitchListTile(
              //     title: TextWidget(
              //       text: "Dark Mode",
              //       color: color,
              //       textSize: 24,
              //       isTitle: true,
              //     ),
              //     secondary: Icon(themeState.getDarkTheme
              //         ? Icons.dark_mode_outlined
              //         : Icons.light_mode_outlined),
              //     value: themeState.getDarkTheme,
              //     onChanged: (bool value) {
              //       setState(() {
              //         themeState.setDarkTheme = value;
              //       });
              //     }),
              _listTiles(
                  title: 'Logout',
                  color: color,
                  icon: IconlyLight.logout,
                  onPressed: () {
                    _showLogoutDialog();
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
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Update"),
              ),
            ],
          );
        });
  }

  Future<void> _showLogoutDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/warning-sign.png',
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                ),
                const SizedBox(width: 5),
                const Text("Sign Out")
              ],
            ),
            content: const Text("Do you want to sign out"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(onPressed: () {}, child: const Text("Ok"))
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
        textSize: 24,
        isTitle: true,
      ),
      subtitle: TextWidget(text: subtitle ?? "", color: color, textSize: 18),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
