import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_dimensions.dart';

class ErrorImagePlaceholder extends StatelessWidget {
  const ErrorImagePlaceholder({
    super.key,
    this.height,
    this.width,
    this.padding = EdgeInsets.zero,
  });

  final double? height;
  final double? width;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimensions.defaultBorderRadius),
        ),
      ),
      child: Padding(
        padding: padding,
        child: const Center(child: Icon(Icons.error)),
      ),
    );
  }
}
