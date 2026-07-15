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
        return '';
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

  double? get calculateDiscountedPrice {
    if ((discountPercent ?? 0) > 0) {
      return amount - (amount * discountPercent! / 100);
    }
    return null;
  }

  String get formatted => amount.asPrice(currency);
  String? get formattedDiscountedPrice {
    return calculateDiscountedPrice?.asPrice(currency);
  }
}
