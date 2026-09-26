import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.label,
    required this.spendingAmount,
    required this.spendingPctOfTotal,
  });

  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  BorderRadius get _borderRadius => BorderRadius.circular(8);

  Color _barColor(BuildContext context) {
    return Theme.of(context).colorScheme.secondary.withAlpha(50);
  }

  Color _fillColor(BuildContext context) {
    switch (spendingPctOfTotal) {
      case < 0.25:
        return Colors.green;
      case < 0.5:
        return Colors.amber;
      case < 0.75:
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text('\$${spendingAmount.round().toString()}'),
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.08),
            Expanded(
              child: SizedBox(
                width: 8,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: _barColor(context),
                        borderRadius: _borderRadius,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        heightFactor: spendingPctOfTotal,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _fillColor(context),
                            borderRadius: _borderRadius,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.08),
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FittedBox(child: Text(label)),
              ),
            ),
          ],
        );
      },
    );
  }
}
