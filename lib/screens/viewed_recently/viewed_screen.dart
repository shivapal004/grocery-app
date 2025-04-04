import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/screens/viewed_recently/viewed_widget.dart';
import 'package:provider/provider.dart';

import '../../provider/viewed_provider.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/empty_screen.dart';
import '../../widgets/text_widget.dart';

class ViewedScreen extends StatelessWidget {
  static const routeName = '/ViewedScreen';

  const ViewedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final viewedProdProvider = Provider.of<ViewedProvider>(context);
    final viewedProdItemsList = viewedProdProvider.getViewedProdListItems.values
        .toList()
        .reversed
        .toList();
    if (viewedProdItemsList.isEmpty) {
      return const EmptyScreen(
        title: 'Your history is empty',
        subtitle: 'No products has been viewed yet!',
        buttonText: 'Shop now',
        imagePath: 'assets/images/history.png',
      );
    } else {
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
            itemCount: viewedProdItemsList.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                  value: viewedProdItemsList[index],
                  child: const ViewedWidget());
            }),
      );
    }
  }
}
