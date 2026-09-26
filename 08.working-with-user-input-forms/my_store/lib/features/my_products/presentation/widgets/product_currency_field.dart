import 'package:flutter/material.dart';
import 'package:my_store/features/my_products/presentation/widgets/field_label.dart';
import 'package:my_store/shared/widgets/app_dropdown.dart';

class ProductCurrencyField extends StatelessWidget {
  const ProductCurrencyField({
    super.key,
    required this.selectedCurrency,
    required this.validCurrencies,
    required this.onCurrencySelected,
  });

  final String selectedCurrency;
  final List<String> validCurrencies;
  final ValueChanged<String?> onCurrencySelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel(label: 'Currency', isRequired: true),
        AppDropdown(
          value: selectedCurrency,
          items: validCurrencies,
          onChanged: onCurrencySelected,
        ),
      ],
    );
  }
}
