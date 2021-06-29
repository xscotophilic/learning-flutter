import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import './components/body.dart';
import './edit_product_screen.dart';
import '../../helpers/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context),
        drawer: AppDrawer(),
        body: Body(),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: SvgPicture.asset(
            "assets/icons/menu.svg",
            color: Theme.of(context).accentColor,
            width: 20,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Text(
        'Your Products',
        style: Theme.of(context).textTheme.headline3!.copyWith(
              color: Theme.of(context).accentColor,
            ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              EditProductScreen.routeName,
              arguments: 'tinfoilhat',
            );
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
