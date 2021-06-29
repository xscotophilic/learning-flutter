import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import '../../../screens/orders/orders_screen.dart';
import '../../../screens/user_products/user_products.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        elevation: 0,
        child: Column(
          children: [
            AppBar(
              title: Center(
                child: SvgPicture.asset(
                  "assets/icons/logo.svg",
                  height: 26,
                ),
              ),
              automaticallyImplyLeading: false,
              elevation: 3,
            ),
            buildListTile(
              context: context,
              title: 'Shop',
              icon: Icons.shop,
              tapHandler: () => Navigator.of(context).pushReplacementNamed('/'),
            ),
            buildListTile(
              context: context,
              title: 'Orders',
              icon: Icons.payment,
              tapHandler: () => Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName),
            ),
            buildListTile(
              context: context,
              title: 'My Products',
              icon: Icons.edit,
              tapHandler: () => Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName),
            ),
            buildListTile(
              context: context,
              title: 'Logout',
              icon: Icons.exit_to_app,
              tapHandler: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Function tapHandler,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24,
        color: Theme.of(context).accentColor,
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: Theme.of(context).accentColor),
      ),
      onTap: () => tapHandler(),
    );
  }
}
