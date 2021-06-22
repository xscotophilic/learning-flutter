import 'package:flutter/material.dart';

import '../../../const.dart';
import '../../../providers/product.dart';
import './description.dart';
import './product_title_with_image.dart';

class Body extends StatelessWidget {
  final Product selectedProduct;

  const Body({
    Key? key,
    required this.selectedProduct,
  }) : super(key: key);
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
                  left: Constants.kDefaultPaddin,
                  right: Constants.kDefaultPaddin,
                ),
                // height: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Description(product: selectedProduct),
                    ],
                  ),
                ),
              ),
              ProductTitleWithImage(
                product: selectedProduct,
              ),
            ],
          ),
        )
      ],
    ));
  }
}
