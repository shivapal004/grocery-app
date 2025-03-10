import 'package:flutter/cupertino.dart';

class GlobalMethods{
  static navigateTo(BuildContext context, String routeName){
    Navigator.pushNamed(context, routeName);
  }
}