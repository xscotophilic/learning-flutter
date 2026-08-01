import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_dimensions.dart';

class FieldLabel extends StatelessWidget {
  const FieldLabel({super.key, required this.label, this.isRequired = false});

  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.defaultMargin / 4),
      child: RichText(
        text: TextSpan(
          text: label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          children: [
            if (isRequired)
              TextSpan(
                text: ' *',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
