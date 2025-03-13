import 'package:flutter/material.dart';

class MenuController extends ChangeNotifier{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _gridScaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _appProductScaffoldKey = GlobalKey<ScaffoldState>();

   GlobalKey<ScaffoldState> get getScaffoldKey => _scaffoldKey;
  GlobalKey<ScaffoldState> get getGridScaffoldKey => _scaffoldKey;
  GlobalKey<ScaffoldState> get getAddProductScaffoldKey => _scaffoldKey;

  void controlDashboardMenu(){
    if(!_scaffoldKey.currentState!.isDrawerOpen){
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void controlProductMenu(){
    if(!_gridScaffoldKey.currentState!.isDrawerOpen){
      _gridScaffoldKey.currentState!.openDrawer();
    }
  }

  void controlAddProductMenu(){
    if(!_appProductScaffoldKey.currentState!.isDrawerOpen){
      _appProductScaffoldKey.currentState!.openDrawer();
    }
  }
}