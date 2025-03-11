import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/screens/viewed_recently/viewed_widget.dart';

import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/text_widget.dart';

class ViewedScreen extends StatelessWidget {
  static const routeName = '/ViewedScreen';

  const ViewedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final themeState = utils.getTheme;
    Size size = utils.screenSize;
    final Color color = utils.color;
    bool isEmpty = true;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackWidget(),
        centerTitle: true,
        title: TextWidget(
            text: "History", color: utils.color, textSize: 20, isTitle: true),
        actions: [
          IconButton(
              onPressed: () {
                GlobalMethods.warningDialog(
                    title: 'Empty you history',
                    subtitle: 'Are you sure?',
                    function: () {},
                    context: context);
              },
              icon: const Icon(IconlyBroken.delete))
        ],
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return const ViewedWidget();
          }),
    );
  }
}
