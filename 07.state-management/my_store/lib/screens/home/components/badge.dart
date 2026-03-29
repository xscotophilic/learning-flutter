import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  const Badge({super.key, required this.value, required this.child});

  final String value;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.all(2.0),
            constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
            child: Text(value, textAlign: TextAlign.center),
          ),
        ),
      ],
    );
  }
}
