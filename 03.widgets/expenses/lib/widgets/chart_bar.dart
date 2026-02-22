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
    return Column(
      children: <Widget>[
        FittedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('\$${spendingAmount.round().toString()}'),
          ),
        ),
        SizedBox(height: 4),
        SizedBox(
          height: 64,
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
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
