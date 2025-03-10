import 'package:flutter/material.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/category_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),
  ];

  List<Map<String, dynamic>> catInfo = [
    {
      'imgPath': 'assets/images/category/fruits.png',
      'catText': 'Fruits',
    },
    {
      'imgPath': 'assets/images/category/veg.png',
      'catText': 'Vegetables',
    },
    {
      'imgPath': 'assets/images/category/Spinach.png',
      'catText': 'Herbs',
    },
    {
      'imgPath': 'assets/images/category/nuts.png',
      'catText': 'nuts',
    },
    {
      'imgPath': 'assets/images/category/spices.png',
      'catText': 'Spices',
    },
    {
      'imgPath': 'assets/images/category/grains.png',
      'catText': 'Grains',
    },
  ];

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
            text: "Category Screen",
            color: utils.color,
            textSize: 20,
            isTitle: true),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 240 / 250,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: List.generate(6, (index) {
              return CategoryWidget(
                catText: catInfo[index]['catText'],
                imgPath: catInfo[index]['imgPath'],
                passedColor: gridColors[index],
              );
            })),
      ),
    );
  }
}
