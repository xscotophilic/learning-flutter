import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_variables.dart';
import 'package:my_store/features/home/presentation/home_page.dart';
import 'package:my_store/features/orders/presentation/orders_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  ListTile _buildListTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Function tapHandler,
  }) {
    return ListTile(
      leading: Icon(icon, size: 24),
      title: Text(title),
      onTap: () => tapHandler(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Drawer(
      elevation: 0,
      child: SafeArea(
        child: Column(
          children: [
            Text(
              AppVariables.appName.toUpperCase(),
              style: textTheme.titleMedium,
            ),
            _buildListTile(
              context: context,
              title: 'Shop',
              icon: Icons.storefront,
              tapHandler: () {
                Navigator.of(context).pushReplacementNamed(HomePage.routeName);
              },
            ),
            _buildListTile(
              context: context,
              title: 'Orders',
              icon: Icons.receipt_long_outlined,
              tapHandler: () {
                Navigator.of(
                  context,
                ).pushReplacementNamed(OrdersPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
