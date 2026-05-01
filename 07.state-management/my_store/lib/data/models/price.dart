extension CurrencyExtension on String {
  String get asCurrencySymbol {
    switch (this) {
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      default:
        return '?';
    }
  }
}

extension PriceFormatting on double {
  String asPrice(String currency) {
    return '${currency.asCurrencySymbol}${toStringAsFixed(2)}';
  }
}

class Price {
  const Price({
    required this.amount,
    required this.currency,
    this.discountPercent,
  });

  final double amount;
  final String currency;
  final double? discountPercent;

  String get formatted => amount.asPrice(currency);
}
