import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_consts.dart';
import 'package:my_store/core/consts/app_variables.dart';
import 'package:my_store/data/store/mock_data.dart';
import 'package:my_store/features/cart/presentation/cart_page.dart';
import 'package:my_store/features/home/presentation/widgets/hero_banner.dart';
import 'package:my_store/features/home/presentation/widgets/product_grid.dart';
import 'package:my_store/features/product_details/presentation/product_details_page.dart';
import 'package:my_store/shared/widgets/drawer.dart';
import 'package:my_store/shared/widgets/main_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        title: AppVariables.appName.toUpperCase(),
        leadingIcon: Icons.menu_rounded,
        onLeadingTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        trailingIcon: Icons.shopping_bag_outlined,
        onTrailingTap: () {
          Navigator.pushNamed(context, CartPage.routeName);
        },
      ),
      drawer: const AppDrawer(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppConsts.defaultPadding),
        children: [
          HeroBanner(
            title: 'Rock your taste buds with our cookies',
            imageUrl: MockData.heroProduct.imageUrl,
            ctaText: 'SHOP NOW',
            onTap: () {
              Navigator.pushNamed(
                context,
                ProductDetailsPage.routeName,
                arguments: MockData.heroProduct.id,
              );
            },
          ),
          const SizedBox(height: AppConsts.defaultMargin / 2),
          Text(
            'Featured Products',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: AppConsts.defaultMargin),
          ProductGrid(
            products: MockData.products,
            onProductTap: (product) {
              Navigator.pushNamed(
                context,
                ProductDetailsPage.routeName,
                arguments: product.id,
              );
            },
          ),
        ],
      ),
    );
  }
}
