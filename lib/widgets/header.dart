import 'package:flutter/material.dart';
import 'package:grocery_app/responsive.dart';
import 'package:grocery_app/services/utils.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.function});

  final Function function;

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    Color color = utils.color;

    return Row(children: [
      if (!Responsive.isDesktop(context))
        IconButton(
            onPressed: () {
              function();
            },
            icon: const Icon(Icons.menu)),
      if (Responsive.isDesktop(context))
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Dashboard",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      if (Responsive.isDesktop(context))
        Spacer(
          flex: Responsive.isDesktop(context) ? 2 : 1,
        ),
      Expanded(
        child: TextField(
          decoration: InputDecoration(
              hintText: 'Search',
              fillColor: Theme.of(context).cardColor,
              filled: true,
              border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              suffixIcon: InkWell(
                onTap: () {},
                child: Container(
                  // padding: const EdgeInsets.all( ),
                  // margin: ,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Icon(
                    Icons.search,
                    size: 25,
                  ),
                ),
              )),
        ),
      )
    ]);
  }
}
