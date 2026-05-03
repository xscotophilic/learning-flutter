import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store/core/consts/app_consts.dart';
import 'package:my_store/core/consts/app_variables.dart';
import 'package:my_store/features/cart/presentation/cart_page.dart';
import 'package:my_store/features/home/domain/models/home_data.dart';
import 'package:my_store/features/home/presentation/providers/home_page_data_notifier.dart';
import 'package:my_store/features/home/presentation/widgets/featured_products_grid.dart';
import 'package:my_store/features/home/presentation/widgets/hero_banner.dart';
import 'package:my_store/features/product_details/presentation/product_details_page.dart';
import 'package:my_store/shared/widgets/drawer.dart';
import 'package:my_store/shared/widgets/generic_error_view.dart';
import 'package:my_store/shared/widgets/generic_progress_indicator.dart';
import 'package:my_store/shared/widgets/main_app_bar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  static const routeName = '/';

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final homePageDataAsync = ref.watch(homePageDataProvider);
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
      body: Padding(
        padding: const EdgeInsets.all(AppConsts.defaultPadding),
        child: homePageDataAsync.when(
          loading: () {
            return const Center(child: GenericProgressIndicator());
          },
          error: (Object error, StackTrace _) {
            return Center(
              child: GenericErrorView(
                onRetry: () => ref.invalidate(homePageDataProvider),
              ),
            );
          },
          data: (homePageData) {
            return _HomePageBody(homePageData: homePageData);
          },
        ),
      ),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({required this.homePageData});

  final HomePageData homePageData;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        HeroBanner(
          foregroundImageUrl: homePageData.heroProduct.imageUrl,
          title: 'Rock your taste buds with our cookies',
          buttonText: 'SHOP NOW',
          onButtonPressed: () {
            Navigator.pushNamed(
              context,
              ProductDetailsPage.routeName,
              arguments: homePageData.heroProduct.id,
            );
          },
        ),

        const SizedBox(height: AppConsts.defaultMargin),

        Text(
          'Featured Products',
          style: Theme.of(context).textTheme.titleSmall,
        ),

        const SizedBox(height: AppConsts.defaultMargin),

        FeaturedProductsGrid(products: homePageData.featuredProducts),
      ],
    );
  }
}
