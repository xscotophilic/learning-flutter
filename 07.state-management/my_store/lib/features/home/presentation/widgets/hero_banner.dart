import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_consts.dart';
import 'package:my_store/core/theme/app_theme.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.ctaText,
    required this.onTap,
  });

  final String title;
  final String imageUrl;
  final String ctaText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final contentWidth = constraints.maxWidth * 0.62;
        final imageWidth =
            constraints.maxWidth - contentWidth - AppConsts.defaultPadding;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(AppConsts.defaultPadding),
              decoration: BoxDecoration(
                gradient: theme.extension<AppGradients>()?.cardGradient,
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
                      ElevatedButton(onPressed: onTap, child: Text(ctaText)),
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
                  imageUrl,
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
