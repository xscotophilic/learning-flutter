import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../providers/products.dart';
import '../../providers/product.dart';
import '../../const.dart';
import './components/body.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/ProductDetails';

  const ProductDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context)!.settings.arguments as String;

    final Product product =
        Provider.of<Products>(context, listen: false).findByID(productID);

    return Scaffold(
      // each product have a color
      backgroundColor: product.color,
      appBar: buildAppBar(context, product.title, product.color),
      body: Body(selectedProduct: product),
    );
  }

  AppBar buildAppBar(BuildContext context, String title, Color product_color) {
    return AppBar(
      backgroundColor: product_color,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Theme.of(context).primaryColor),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/cart.svg"),
          onPressed: () {},
        ),
        SizedBox(width: Constants.kDefaultPaddin / 2)
      ],
    );
  }
}
