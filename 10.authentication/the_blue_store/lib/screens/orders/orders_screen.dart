import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_drawer.dart';

import './components/body.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: AppDrawer(),
      body: Body(),
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
        'Orders',
        style: Theme.of(context).textTheme.headline3!.copyWith(
              color: Theme.of(context).accentColor,
            ),
      ),
    );
  }
}
