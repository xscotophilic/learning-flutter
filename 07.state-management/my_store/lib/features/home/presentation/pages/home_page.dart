import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_consts.dart';
import 'package:my_store/core/consts/app_variables.dart';
import 'package:my_store/core/theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppVariables.appName.toUpperCase(),
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: _DecoratedIconCta(icon: Icons.menu, onTap: () {}),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppConsts.defaultPadding / 2),
            child: _DecoratedIconCta(
              icon: Icons.shopping_bag_outlined,
              onTap: () {},
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConsts.defaultPadding),
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final contentWidth = constraints.maxWidth * 0.6;
                final imageWidth = constraints.maxWidth * 0.4;
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: Theme.of(
                            context,
                          ).extension<AppGradients>()?.cardGradient,
                          borderRadius: BorderRadius.circular(
                            AppConsts.defaultBorderRadius,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(
                            AppConsts.defaultPadding,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width:
                                    contentWidth - (AppConsts.defaultPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: AppConsts.defaultMargin / 3,
                                    ),
                                    Text(
                                      'Rock your taste buds with our cookies',
                                      style: textTheme.bodyLarge?.copyWith(
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: AppConsts.defaultMargin / 4,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Shop Now',
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: theme.colorScheme.onPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: AppConsts.defaultPadding,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: AppConsts.defaultPadding,
                        ),
                        child: Image.network(
                          'https://i.ibb.co/9mS5StLX/choco-chip-cookie.webp',
                          height: imageWidth - AppConsts.defaultPadding,
                          width: imageWidth - AppConsts.defaultPadding,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DecoratedIconCta extends StatelessWidget {
  const _DecoratedIconCta({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Icon(icon),
      ),
    );
  }
}
