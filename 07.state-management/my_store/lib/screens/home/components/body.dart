import 'package:flutter/material.dart';
import 'package:my_store/helpers/app_consts.dart';
import 'package:my_store/screens/home/components/products_grid.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key, required this.showOnlyFavs});

  final bool showOnlyFavs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(Constants.kDefaultPadding),
            child: ProductsGrid(showOnlyFavs: showOnlyFavs),
          ),
        ),
      ],
    );
  }
}
