import 'package:flutter/material.dart';

class DecoratedIconCta extends StatelessWidget {
  const DecoratedIconCta({
    super.key,
    required this.icon,
    this.iconColor,
    this.iconSize,
    required this.onTap,
  });

  final IconData icon;
  final Color? iconColor;
  final double? iconSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: iconColor, size: iconSize),
      ),
    );
  }
}
