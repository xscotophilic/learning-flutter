import 'package:appetite_assorted/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = '/filters';

  const FiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context, 'Filters'),
        drawer: MainDrawer(),
        body: null,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, String title) {
    return AppBar(
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: SvgPicture.asset(
            "assets/icons/menu.svg",
            color: Theme.of(context).accentColor,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Text(title),
    );
  }
}
