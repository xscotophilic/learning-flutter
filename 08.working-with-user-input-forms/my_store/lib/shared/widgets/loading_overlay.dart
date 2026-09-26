import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    this.borderRadius,
    required this.isLoading,
    required this.child,
  });

  final BorderRadius? borderRadius;
  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(ignoring: isLoading, child: child),
        if (isLoading)
          Positioned.fill(
            child: ClipRRect(
              borderRadius: borderRadius ?? BorderRadius.zero,
              child: ColoredBox(
                color: Theme.of(context).colorScheme.onSecondary.withAlpha(07),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
      ],
    );
  }
}
