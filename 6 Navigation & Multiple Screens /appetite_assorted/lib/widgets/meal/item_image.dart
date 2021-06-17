import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  final String imgSrc;

  const ItemImage({
    required this.imgSrc,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.25,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
      ),
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 15),
        child: Image.network(
          imgSrc,
          height: size.height * 0.25,
          // it cover the 25% of total height
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
