class Total {
  const Total({
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.currency,
  });

  final double subtotal;
  final double discount;
  final double total;
  final String currency;
}
