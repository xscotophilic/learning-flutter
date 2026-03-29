import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_store/const.dart';
import 'package:my_store/providers/product.dart';
import 'package:my_store/providers/products.dart';
import 'package:my_store/screens/product_details/components/body.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context)!.settings.arguments as String;

    final Product product = Provider.of<Products>(
      context,
      listen: false,
    ).findByID(productID);

    return Scaffold(
      // each product have a color
      backgroundColor: product.color,
      appBar: buildAppBar(context, product.title, product.color),
      body: ProductDetailsBody(selectedProduct: product),
    );
  }

  AppBar buildAppBar(BuildContext context, String title, Color productColor) {
    return AppBar(
      backgroundColor: productColor,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).primaryColor),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset('assets/icons/cart.svg'),
          onPressed: () {},
        ),
        const SizedBox(width: Constants.kDefaultPadding / 2),
      ],
    );
  }
}
