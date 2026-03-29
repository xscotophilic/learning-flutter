import 'package:flutter/material.dart';

import 'package:my_store/screens/orders/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        children: [
          AppBar(
            title: const Text('The Blue Store'),
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
            tapHandler: () => Navigator.of(
              context,
            ).pushReplacementNamed(OrdersScreen.routeName),
          ),
        ],
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
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      onTap: () => tapHandler(),
    );
  }
}
