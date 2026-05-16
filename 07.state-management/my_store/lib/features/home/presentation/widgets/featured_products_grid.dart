import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store/core/consts/app_dimensions.dart';
import 'package:my_store/features/home/presentation/widgets/featured_product_card.dart';
import 'package:my_store/shared/product/presentation/providers/product_notifier.dart';

class FeaturedProductsGrid extends ConsumerWidget {
  const FeaturedProductsGrid({super.key, required this.productIds});

  final List<String> productIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productStates = productIds.map((id) {
      return ref.watch(
        productProvider(id).select(
          (state) => (
            isLoading: state.isLoading,
            hasError: state.hasError,
            hasValue: state.hasValue,
            isNull: state.value == null,
          ),
        ),
      );
    }).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        const double maxCrossAxisExtent = 256.0 + AppDimensions.defaultMargin;
        final int columnCount = (constraints.maxWidth / maxCrossAxisExtent)
            .ceil();

        final List<Widget> visibleCards = [];
        for (int i = 0; i < productIds.length; i++) {
          final id = productIds[i];
          final state = productStates[i];

          if (state.isLoading ||
              (!state.hasError && state.hasValue && !state.isNull)) {
            visibleCards.add(FeaturedProductCard(productId: id));
          }
        }

        if (visibleCards.isEmpty) {
          return const Text('No items available at the moment.');
        }

        final List<List<Widget>> columns = List.generate(
          columnCount,
          (_) => <Widget>[],
        );

        for (int i = 0; i < visibleCards.length; i++) {
          columns[i % columnCount].add(visibleCards[i]);
        }

        final bool enableMasonryGrid = columnCount % 2 == 0;
        final double paddingOffset = AppDimensions.defaultPadding * 3;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < columnCount; i++) ...[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: enableMasonryGrid && i % 2 != 0 ? paddingOffset : 0.0,
                  ),
                  child: Column(
                    children: columns[i].map((card) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppDimensions.defaultMargin,
                        ),
                        child: card,
                      );
                    }).toList(),
                  ),
                ),
              ),
              if (i < columnCount - 1) ...[
                const SizedBox(width: AppDimensions.defaultMargin),
              ],
            ],
          ],
        );
      },
    );
  }
}
