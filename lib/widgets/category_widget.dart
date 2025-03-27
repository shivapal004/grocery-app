import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../inner_screens/category_screen.dart';
import '../provider/dark_theme_provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required this.catText, required this.imgPath, required this.passedColor});

  final String catText, imgPath;
  final Color passedColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeStatus = Provider.of<DarkThemeProvider>(context);
    final Color color = themeStatus.getDarkTheme ? Colors.white : Colors.black;
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, CategoryScreen.routeName, arguments: catText);
      },
      child: Container(
        // height: size.width * .4,
        decoration: BoxDecoration(
            color: passedColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: passedColor.withOpacity(0.7), width: 2)),
        child: Column(
          children: [
            Container(
              width: size.width * .3,
              height: size.width * .3,
              decoration:  BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        imgPath,
                      ),
                      fit: BoxFit.fill)),
            ),
            TextWidget(
              text: catText,
              color: color,
              textSize: 20,
              isTitle: true,
            )
          ],
        ),
      ),
    );
  }
}
