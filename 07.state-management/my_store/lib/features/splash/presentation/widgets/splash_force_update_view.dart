import 'package:flutter/material.dart';
import 'package:my_store/features/splash/presentation/widgets/splash_action_view.dart';

class SplashForceUpdateView extends StatelessWidget {
  const SplashForceUpdateView({super.key, required this.message, this.details});

  final String message;
  final String? details;

  @override
  Widget build(BuildContext context) {
    return SplashActionView(
      title: message,
      details: details,
      ctaLabel: 'Update Now',
      onCtaPressed: () {},
    );
  }
}
