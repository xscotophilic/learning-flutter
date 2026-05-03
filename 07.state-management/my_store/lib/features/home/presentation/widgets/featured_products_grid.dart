import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_consts.dart';
import 'package:my_store/data/models/product.dart';
import 'package:my_store/features/home/presentation/widgets/featured_product_card.dart';
import 'package:my_store/features/product_details/presentation/product_details_page.dart';

class FeaturedProductsGrid extends StatefulWidget {
  const FeaturedProductsGrid({super.key, required this.products});

  final List<Product> products;

  @override
  State<FeaturedProductsGrid> createState() => _FeaturedProductsGridState();
}

class _FeaturedProductsGridState extends State<FeaturedProductsGrid> {
  int _columnCount = 0;
  List<List<Product>> _columns = [];

  void _onProductTap(String productId) {
    Navigator.pushNamed(
      context,
      ProductDetailsPage.routeName,
      arguments: productId,
    );
  }

  void _recompute(double availableWidth) {
    const double maxCrossAxisExtent = 256.0 + AppConsts.defaultMargin;
    final int columnCount = (availableWidth / maxCrossAxisExtent).ceil();

    _columnCount = columnCount;
    _columns = List.generate(columnCount, (_) => <Product>[]);
    for (int i = 0; i < widget.products.length; i++) {
      _columns[i % columnCount].add(widget.products[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _recompute(constraints.maxWidth);

        final enableMasonryGrid = _columnCount == 2;
        final paddingOffset = AppConsts.defaultPadding * 3;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < _columnCount; i++) ...[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: enableMasonryGrid && i == 1 ? paddingOffset : 0.0,
                  ),
                  child: Column(
                    children: _columns[i].map((p) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppConsts.defaultMargin,
                        ),
                        child: FeaturedProductCard(
                          product: p,
                          onTap: () => _onProductTap(p.id),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              if (i < _columnCount - 1) ...[
                const SizedBox(width: AppConsts.defaultMargin),
              ],
            ],
          ],
        );
      },
    );
  }
}
