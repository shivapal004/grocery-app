import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/header.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Header(function: (){
              // context.read<MenuController>().controlDashboardMenu();
            })

          ],
        ),
      ),
    );
  }
}
