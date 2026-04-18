import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_consts.dart';
import 'package:my_store/core/consts/app_variables.dart';
import 'package:my_store/features/home/presentation/widgets/hero_banner.dart';
import 'package:my_store/shared/widgets/decorated_icon_cta.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  AppBar _buildAppBar(TextTheme textTheme) {
    return AppBar(
      title: Text(
        AppVariables.appName.toUpperCase(),
        style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      leading: DecoratedIconCta(icon: Icons.menu, onTap: () {}),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: AppConsts.defaultPadding / 2),
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
      body: Padding(
        padding: const EdgeInsets.all(AppConsts.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeroBanner(
              title: 'Rock your taste buds with our cookies',
              imageUrl: 'https://i.ibb.co/9mS5StLX/choco-chip-cookie.webp',
              ctaText: 'SHOP NOW',
              onTap: () {},
            ),
            Text(
              'Featured Products',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: AppConsts.defaultMargin / 2),
          ],
        ),
      ),
    );
  }
}
