import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_consts.dart';
import 'package:my_store/core/consts/app_variables.dart';
import 'package:my_store/data/store/mock_data.dart';
import 'package:my_store/features/home/presentation/widgets/hero_banner.dart';
import 'package:my_store/features/home/presentation/widgets/product_grid.dart';
import 'package:my_store/features/product_details/product_details_page.dart';
import 'package:my_store/shared/widgets/decorated_icon_cta.dart';
import 'package:my_store/shared/widgets/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/';

  AppBar _buildAppBar(TextTheme textTheme) {
    return AppBar(
      title: Text(
        AppVariables.appName.toUpperCase(),
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: AppConsts.defaultPadding),
          child: DecoratedIconCta(
            icon: Icons.shopping_bag_outlined,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(Theme.of(context).textTheme),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConsts.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
      ),
    );
  }
}
