import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_consts.dart';
import 'package:my_store/core/theme/app_theme.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({
    super.key,
    required this.foregroundImageUrl,
    required this.title,
    required this.buttonText,
    required this.onButtonPressed,
  });

  final String foregroundImageUrl;
  final String title;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final contentWidth = constraints.maxWidth * 0.62;
        final imageWidth = constraints.maxWidth > 420
            ? 100.0
            : constraints.maxWidth - contentWidth - AppConsts.defaultPadding;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(AppConsts.defaultPadding),
              decoration: BoxDecoration(
                gradient: theme.extension<AppGradients>()?.bannerGradient,
                borderRadius: BorderRadius.circular(
                  AppConsts.defaultBorderRadius,
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: contentWidth - AppConsts.defaultPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: AppConsts.defaultMargin / 2),
                      ElevatedButton(
                        onPressed: onButtonPressed,
                        child: Text(buttonText),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentGeometry.bottomRight,
              child: Padding(
                padding: const EdgeInsetsGeometry.only(
                  top: AppConsts.defaultPadding,
                  right: AppConsts.defaultPadding,
                ),
                child: Image.network(
                  foregroundImageUrl,
                  height: imageWidth,
                  width: imageWidth,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
