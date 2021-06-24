import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import './components/body.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Theme.of(context).accentColor,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Cart',
        style: Theme.of(context).textTheme.headline3!.copyWith(
              color: Theme.of(context).accentColor,
            ),
      ),
    );
  }
}
