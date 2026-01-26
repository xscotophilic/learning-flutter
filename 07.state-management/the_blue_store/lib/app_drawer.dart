import 'package:flutter/material.dart';

import '../../../screens/orders/orders_screen.dart';

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
              title: Text('The Blue Store'),
              automaticallyImplyLeading: false,
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
