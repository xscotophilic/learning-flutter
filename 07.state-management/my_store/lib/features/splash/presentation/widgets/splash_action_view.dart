import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_dimensions.dart';

class SplashActionView extends StatelessWidget {
  const SplashActionView({
    super.key,
    required this.title,
    this.details,
    required this.ctaLabel,
    required this.onCtaPressed,
  });

  final String title;
  final String? details;
  final String ctaLabel;
  final VoidCallback onCtaPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.defaultMargin * 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDimensions.defaultMargin),

          Container(
            width: AppDimensions.defaultMargin * 3,
            height: AppDimensions.defaultMargin / 4,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          if (details != null) ...[
            const SizedBox(height: AppDimensions.defaultMargin),
            Text(
              details!,
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.5),
                height: 1.75,
              ),
            ),
          ],

          const SizedBox(height: AppDimensions.defaultMargin * 1.5),
          GestureDetector(
            onTap: onCtaPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    ctaLabel.toUpperCase(),
                    style: textTheme.titleSmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.defaultMargin),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: colorScheme.primary,
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
