import 'package:flutter/material.dart';
import 'package:my_store/shared/widgets/decorated_icon_cta.dart';
import 'package:my_store/shared/widgets/drawer.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  static const routeName = '/orders';

  AppBar _buildAppBar(TextTheme textTheme) {
    return AppBar(
      title: Text(
        'Orders',
        style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      leading: Builder(
        builder: (context) {
          return DecoratedIconCta(
            icon: Icons.menu_rounded,
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: _buildAppBar(textTheme),
      drawer: const AppDrawer(),
      body: const Center(child: Text('Orders')),
    );
  }
}
