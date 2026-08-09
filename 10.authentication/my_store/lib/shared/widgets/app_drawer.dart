import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store/core/consts/app_dimensions.dart';
import 'package:my_store/features/auth/domain/entities/user.dart';
import 'package:my_store/features/auth/presentation/providers/auth_notifier.dart';
import 'package:my_store/features/home/presentation/pages/home_page.dart';
import 'package:my_store/features/my_products/presentation/pages/my_products_page.dart';
import 'package:my_store/features/orders/presentation/pages/orders_page.dart';
import 'package:my_store/shared/widgets/primary_button.dart';
import 'package:my_store/shared/widgets/shimmer.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Widget _buildListTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Function tapHandler,
  }) {
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppDimensions.defaultBorderRadius),
      ),
      onTap: () => tapHandler(),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.defaultPadding / 3),
        child: Row(
          children: [
            Icon(icon, size: AppDimensions.defaultIconSize),
            const SizedBox(width: AppDimensions.defaultMargin / 2),
            Text(title),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Drawer(
      elevation: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.defaultPadding / 1.25,
          ),
          child: Column(
            children: [
              const SizedBox(height: AppDimensions.defaultMargin / 2),
              Consumer(
                builder: (context, ref, child) {
                  final authAsync = ref.watch(authProvider);
                  return authAsync.when(
                    skipLoadingOnRefresh: false,
                    loading: () {
                      return Shimmer(
                        enabled: true,
                        baseColor: colorScheme.onSurface.withAlpha(120),
                        highlightColor: colorScheme.onSurface.withAlpha(60),
                        child: const _AuthSection(user: null),
                      );
                    },
                    error: (Object error, StackTrace _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _AuthSection(user: null),
                          const SizedBox(
                            height: AppDimensions.defaultMargin / 1.5,
                          ),
                          Text(
                            'Oops! Something went wrong. Please try again.',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: colorScheme.error),
                          ),
                        ],
                      );
                    },
                    data: (snapshot) {
                      return Shimmer(
                        enabled: snapshot.isMutating,
                        child: _AuthSection(user: snapshot.user),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: AppDimensions.defaultMargin),
              Divider(color: colorScheme.onSurface, height: 0, thickness: 0.25),
              const SizedBox(height: AppDimensions.defaultMargin / 1.5),
              _buildListTile(
                context: context,
                title: 'Shop',
                icon: Icons.storefront,
                tapHandler: () {
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(HomePage.routeName);
                },
              ),
              const SizedBox(height: AppDimensions.defaultMargin / 2),
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
              const SizedBox(height: AppDimensions.defaultMargin / 2),
              _buildListTile(
                context: context,
                title: 'My Products',
                icon: Icons.inventory_2_outlined,
                tapHandler: () {
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(MyProductsPage.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthSection extends ConsumerWidget {
  const _AuthSection({required this.user});

  final User? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.defaultPadding),
      decoration: BoxDecoration(
        color: colorScheme.primary.withAlpha(30),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimensions.defaultBorderRadius),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: AppDimensions.defaultIconSize,
                backgroundColor: colorScheme.surface.withAlpha(150),
                foregroundColor: colorScheme.onSurface,
                child: user == null
                    ? const Icon(Icons.person_2_outlined)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.defaultIconSize,
                        ),
                        child: Image.network(user?.picture ?? ''),
                      ),
              ),
              const SizedBox(width: AppDimensions.defaultMargin),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.defaultPadding / 4,
                  ),
                  child: Text(
                    user?.name ??
                        'Shop what you love.\nSell something you make.',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.defaultMargin),
          PrimaryButton(
            text: user == null ? 'Sign In' : 'Sign Out',
            fullWidth: true,
            onTap: () {
              if (user == null) {
                ref.read(authProvider.notifier).signInWithGoogle();
              } else {
                ref.read(authProvider.notifier).signOut();
              }
            },
          ),
        ],
      ),
    );
  }
}
