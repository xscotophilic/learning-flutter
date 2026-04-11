import 'package:flutter/material.dart';
import 'package:my_store/helpers/app_consts.dart';
import 'package:my_store/providers/product.dart';
import 'package:my_store/screens/product_details/components/description.dart';
import 'package:my_store/screens/product_details/components/product_title_with_image.dart';

class ProductDetailsBody extends StatelessWidget {
  const ProductDetailsBody({super.key, required this.selectedProduct});

  final Product selectedProduct;

  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height - (size.height * 0.1),
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.06,
                    left: Constants.kDefaultPadding,
                    right: Constants.kDefaultPadding,
                  ),
                  // height: 500,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        ProductDescription(product: selectedProduct),
                      ],
                    ),
                  ),
                ),
                ProductTitleWithImage(product: selectedProduct),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
