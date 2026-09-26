import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store/core/consts/app_dimensions.dart';
import 'package:my_store/core/dependency_injection/network_providers.dart';
import 'package:my_store/features/auth/domain/entities/auth.dart';
import 'package:my_store/features/auth/presentation/providers/auth_notifier.dart';
import 'package:my_store/features/home/presentation/pages/home_page.dart';
import 'package:my_store/features/my_products/presentation/pages/my_products_page.dart';
import 'package:my_store/features/orders/presentation/pages/orders_page.dart';
import 'package:my_store/shared/widgets/primary_button.dart';
import 'package:my_store/shared/widgets/shimmer.dart';
import 'package:my_store/shared/widgets/snackbar.dart';

class AppDrawer extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authProvider);
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
              authAsync.when(
                skipLoadingOnRefresh: false,
                loading: () {
                  return Shimmer(
                    enabled: true,
                    baseColor: colorScheme.onSurface.withAlpha(120),
                    highlightColor: colorScheme.onSurface.withAlpha(60),
                    child: const _AuthSection(),
                  );
                },
                error: (Object error, StackTrace _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _AuthSection(
                        onAuthButtonPressed: () {
                          ref.read(authProvider.notifier).signInWithGoogle();
                        },
                      ),
                      const SizedBox(height: AppDimensions.defaultMargin / 1.5),
                      Text(
                        'Oops! Something went wrong. Please try again.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.error,
                        ),
                      ),
                    ],
                  );
                },
                data: (snapshot) {
                  return Shimmer(
                    enabled: snapshot.isMutating,
                    baseColor: colorScheme.onSurface.withAlpha(120),
                    highlightColor: colorScheme.onSurface.withAlpha(60),
                    child: _AuthSection(
                      user: snapshot.user,
                      onAuthButtonPressed: () {
                        if (snapshot.user == null) {
                          ref.read(authProvider.notifier).signInWithGoogle();
                        } else {
                          ref.read(authProvider.notifier).signOut();
                        }
                      },
                    ),
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
                  final token = ref.read(authTokenProvider);
                  if (token == null) {
                    Navigator.of(context).pop();
                    AppSnackBar.showErrorSnackBar(
                      context,
                      message: 'Please sign in to view your orders.',
                    );
                    return;
                  }
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
                  final token = ref.read(authTokenProvider);
                  if (token == null) {
                    Navigator.of(context).pop();
                    AppSnackBar.showErrorSnackBar(
                      context,
                      message: 'Please sign in to view your products.',
                    );
                    return;
                  }
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

class _AuthSection extends StatelessWidget {
  const _AuthSection({this.user, this.onAuthButtonPressed});

  final User? user;
  final VoidCallback? onAuthButtonPressed;

  @override
  Widget build(BuildContext context) {
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
            onTap: onAuthButtonPressed,
          ),
        ],
      ),
    );
  }
}
