import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  const ItemImage({super.key, required this.imgSrc});

  final String imgSrc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.25,
      width: double.infinity,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      child: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 16),
        child: Image.asset(
          imgSrc,
          height: size.height * 0.25,
          // it cover the 25% of total height
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
