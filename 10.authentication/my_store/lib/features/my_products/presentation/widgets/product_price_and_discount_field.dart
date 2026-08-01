import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_dimensions.dart';
import 'package:my_store/features/my_products/presentation/widgets/field_label.dart';
import 'package:my_store/shared/utils/input_formatters.dart';

class ProductPriceAndDiscountField extends StatelessWidget {
  const ProductPriceAndDiscountField({
    super.key,
    required this.priceController,
    required this.discountController,
  });

  final TextEditingController priceController;
  final TextEditingController discountController;

  String? _priceValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Price is required';
    }
    if ((double.tryParse(value) ?? 0) <= 0) {
      return 'Invalid price';
    }
    return null;
  }

  String? _discountValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      final val = double.tryParse(value);
      if (val == null || val < 0 || val > 100) {
        return 'Must be between 0-100';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FieldLabel(label: 'Price', isRequired: true),
              TextFormField(
                controller: priceController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(hintText: '0.00'),
                inputFormatters: [AppInputFormatters.decimal(decimalPlaces: 2)],
                validator: _priceValidator,
              ),
            ],
          ),
        ),
        const SizedBox(width: AppDimensions.defaultMargin),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FieldLabel(label: 'Discount (%)'),
              TextFormField(
                controller: discountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: '0'),
                inputFormatters: [AppInputFormatters.digitsOnly],
                validator: _discountValidator,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
