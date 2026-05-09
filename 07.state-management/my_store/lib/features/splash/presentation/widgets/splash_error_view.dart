import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_store/features/splash/presentation/widgets/splash_action_view.dart';

class SplashErrorView extends StatelessWidget {
  const SplashErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashActionView(
      title: 'Something went wrong',
      details:
          'We encountered an issue while starting the app. Please try again shortly.',
      ctaLabel: 'Close App',
      onCtaPressed: () => SystemNavigator.pop(),
    );
  }
}
