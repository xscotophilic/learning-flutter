import 'package:flutter/material.dart';
import 'package:my_store/core/theme/app_theme.dart';

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final factor = slidePercent * 4.0 - 2.0;
    return Matrix4.translationValues(
      bounds.width * factor,
      bounds.height * factor,
      0.0,
    );
  }
}

class Shimmer extends StatefulWidget {
  const Shimmer({
    super.key,
    this.baseColor,
    this.highlightColor,
    required this.enabled,
    required this.child,
  });

  final Color? baseColor;
  final Color? highlightColor;
  final bool enabled;
  final Widget child;

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  static const _duration = Duration(milliseconds: 2500);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    if (widget.enabled) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(Shimmer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      if (widget.enabled) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cardColors = theme.extension<AppGradients>()?.cardGradient.colors;
    final defaultColors = [
      colorScheme.primary.withAlpha(100),
      colorScheme.primary.withAlpha(80),
    ];
    final colors = cardColors ?? defaultColors;
    final base = widget.baseColor ?? colors.first;
    final highlight = widget.highlightColor ?? colors.last;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [base, highlight, base],
              stops: const [0.0, 0.5, 1.0],
              transform: _SlidingGradientTransform(
                slidePercent: _controller.value,
              ),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
