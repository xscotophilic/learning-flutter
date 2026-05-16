import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store/core/consts/app_dimensions.dart';
import 'package:my_store/core/consts/app_strings.dart';
import 'package:my_store/features/cart/presentation/pages/cart_page.dart';
import 'package:my_store/features/home/domain/entities/home_page_data.dart';
import 'package:my_store/features/home/presentation/providers/home_notifier.dart';
import 'package:my_store/features/home/presentation/widgets/featured_products_grid.dart';
import 'package:my_store/features/home/presentation/widgets/hero_banner.dart';
import 'package:my_store/features/product_details/presentation/pages/product_details_page.dart';
import 'package:my_store/shared/cart/presentation/widgets/cart_badge.dart';
import 'package:my_store/shared/product/presentation/providers/product_notifier.dart';
import 'package:my_store/shared/widgets/app_drawer.dart';
import 'package:my_store/shared/widgets/generic_error_view.dart';
import 'package:my_store/shared/widgets/generic_progress_indicator.dart';
import 'package:my_store/shared/widgets/main_app_bar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final homePageDataAsync = ref.watch(homeProvider);
    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        title: AppStrings.appName.toUpperCase(),
        leadingIcon: Icons.menu_rounded,
        onLeadingTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        trailing: CartBadge(
          onTap: () {
            Navigator.pushNamed(context, CartPage.routeName);
          },
        ),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.defaultPadding),
        child: homePageDataAsync.when(
          skipLoadingOnRefresh: false,
          loading: () {
            return const Center(child: GenericProgressIndicator());
          },
          error: (Object error, StackTrace _) {
            return Center(
              child: GenericErrorView(
                onRetry: () => ref.invalidate(homeProvider),
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
        Consumer(
          builder: (context, ref, _) {
            final heroProductAsync = ref.watch(
              productProvider(homePageData.heroProductId),
            );

            return heroProductAsync.when(
              data: (heroProduct) {
                if (heroProduct == null) return const SizedBox();

                return HeroBanner(
                  foregroundImageUrl: heroProduct.imageUrl,
                  title: 'Rock your taste buds with our cookies',
                  buttonText: 'SHOP NOW',
                  onButtonPressed: () {
                    Navigator.pushNamed(
                      context,
                      ProductDetailsPage.routeName,
                      arguments: heroProduct.id,
                    );
                  },
                );
              },
              loading: () => const SizedBox(
                height: 200,
                child: Center(child: GenericProgressIndicator()),
              ),
              error: (err, stack) => const SizedBox(),
            );
          },
        ),

        const SizedBox(height: AppDimensions.defaultMargin),

        Text(
          'Featured Products',
          style: Theme.of(context).textTheme.titleSmall,
        ),

        const SizedBox(height: AppDimensions.defaultMargin),

        FeaturedProductsGrid(productIds: homePageData.featuredProductIds),
      ],
    );
  }
}
