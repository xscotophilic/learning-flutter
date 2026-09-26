import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
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
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: icon == null ? null : Icon(icon),
        label: Text(text),
      ),
    );
  }
}
