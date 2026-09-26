import 'package:flutter/services.dart'
    show FilteringTextInputFormatter, TextInputFormatter;

class AppInputFormatters {
  static TextInputFormatter decimal({
    required int decimalPlaces,
    bool allowNegative = false,
  }) {
    final signPattern = allowNegative ? r'-?' : '';
    return FilteringTextInputFormatter.allow(
      RegExp('^$signPattern\\d*\\.?\\d{0,$decimalPlaces}'),
    );
  }

  static final digitsOnly = FilteringTextInputFormatter.digitsOnly;
}
