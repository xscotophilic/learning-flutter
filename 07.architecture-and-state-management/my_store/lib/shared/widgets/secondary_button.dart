import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    this.icon,
    required this.text,
    this.fullWidth = false,
    this.onTap,
  });

  final IconData? icon;
  final String text;
  final bool fullWidth;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: icon == null ? null : Icon(icon),
        label: Text(text),
      ),
    );
  }
}
