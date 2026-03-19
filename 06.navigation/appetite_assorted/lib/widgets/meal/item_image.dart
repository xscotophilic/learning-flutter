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
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface),
      child: Container(
        padding: const EdgeInsets.only(top: 5, bottom: 15),
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
