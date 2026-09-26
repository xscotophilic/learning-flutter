import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_store/features/splash/presentation/widgets/splash_action_view.dart';

class SplashMaintenanceView extends StatelessWidget {
  const SplashMaintenanceView({super.key, required this.message, this.details});

  final String message;
  final String? details;

  @override
  Widget build(BuildContext context) {
    return SplashActionView(
      title: message,
      details: details,
      ctaLabel: 'Close App',
      onCtaPressed: () => exit(0),
    );
  }
}
