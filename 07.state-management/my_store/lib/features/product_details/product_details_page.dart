import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_consts.dart';
import 'package:my_store/data/models/product.dart';
import 'package:my_store/data/store/mock_data.dart';
import 'package:my_store/shared/widgets/decorated_icon_cta.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.productId});

  static const routeName = '/product-details';

  final String? productId;

  AppBar _buildAppBar(TextTheme textTheme) {
    return AppBar(
      title: Text(
        'Details',
        style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      leading: Builder(
        builder: (context) {
          return DecoratedIconCta(
            icon: Icons.arrow_back_ios_new,
            onTap: () {
              Navigator.pop(context);
            },
          );
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: AppConsts.defaultPadding),
          child: DecoratedIconCta(icon: Icons.favorite_border, onTap: () {}),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget child;
    if (productId == null) {
      child = const Center(child: Text('Product not found'));
    } else {
      final product = MockData.products.where((p) {
        return p.id == productId;
      }).firstOrNull;

      if (product == null) {
        child = const Center(child: Text('Product not found'));
      } else {
        final size = MediaQuery.of(context).size;

        child = Padding(
          padding: const EdgeInsets.all(AppConsts.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  product.imageUrl,
                  width: math.min(size.width * 0.60, 256),
                ),
              ),
              const SizedBox(height: AppConsts.defaultPadding * 3),
              Expanded(child: _ProductDetails(product: product)),
              const SizedBox(height: AppConsts.defaultPadding),
              const _CTAPanel(),
              const SizedBox(height: AppConsts.defaultPadding / 2),
            ],
          ),
        );
      }
    }

    return Scaffold(
      appBar: _buildAppBar(Theme.of(context).textTheme),
      body: child,
    );
  }
}

class _PriceSection extends StatelessWidget {
  const _PriceSection({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: product.price.formatted,
            style: textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          if ((product.price.discount ?? '').isNotEmpty) ...[
            const WidgetSpan(
              child: SizedBox(width: AppConsts.defaultPadding / 2),
            ),
            WidgetSpan(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppConsts.defaultBorderRadius / 2),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConsts.defaultPadding / 2,
                    vertical: AppConsts.defaultPadding / 8,
                  ),
                  child: Text(
                    product.price.discount!,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      children: [
        _PriceSection(product: product),
        const SizedBox(height: AppConsts.defaultPadding / 2),
        Text(
          product.name.toUpperCase(),
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: AppConsts.defaultPadding / 2),
        Text(
          product.description,
          style: theme.textTheme.bodyLarge,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

class _CTAPanel extends StatelessWidget {
  const _CTAPanel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          'Add to cart',
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
