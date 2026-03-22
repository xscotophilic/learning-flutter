import 'package:flutter/widgets.dart';

class AutoFitText extends StatelessWidget {
  const AutoFitText({
    super.key,
    required this.text,
    required this.style,
    required this.availableHeight,
  });

  final String text;
  final TextStyle? style;
  final double availableHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final painter = TextPainter(
          text: TextSpan(text: text, style: style),
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final lineMetrics = painter.computeLineMetrics();
        if (lineMetrics.isEmpty) return Text(text, style: style);

        final lineHeight = lineMetrics.first.height;
        final maxLines = (availableHeight / lineHeight).floor().clamp(1, 99);

        return Text(
          text,
          style: style,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }
}
