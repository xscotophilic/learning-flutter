import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_dimensions.dart';
import 'package:my_store/core/consts/app_strings.dart';
import 'package:my_store/shared/widgets/generic_progress_indicator.dart';

class SplashPageContent extends StatelessWidget {
  const SplashPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.appName,
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppDimensions.defaultMargin * 1.5),
          const GenericProgressIndicator(),
        ],
      ),
    );
  }
}
