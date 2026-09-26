import 'package:flutter/material.dart';

class GenericProgressIndicator extends StatelessWidget {
  const GenericProgressIndicator({super.key, this.size = 24});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: const CircularProgressIndicator(),
    );
  }
}
