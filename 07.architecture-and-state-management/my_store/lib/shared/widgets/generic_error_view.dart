import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_dimensions.dart';
import 'package:my_store/shared/widgets/primary_button.dart';

class GenericErrorView extends StatelessWidget {
  const GenericErrorView({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Something went wrong',
          style: textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.defaultMargin / 2),
        Text(
          'Check your connection and try again.',
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.defaultMargin),
        PrimaryButton(
          text: 'Retry',
          icon: Icons.refresh_rounded,
          onTap: onRetry,
        ),
      ],
    );
  }
}
