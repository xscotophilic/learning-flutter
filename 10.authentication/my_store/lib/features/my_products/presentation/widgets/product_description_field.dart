import 'package:flutter/material.dart';
import 'package:my_store/features/my_products/presentation/widgets/field_label.dart';

class ProductDescriptionField extends StatelessWidget {
  const ProductDescriptionField({
    super.key,
    required this.descriptionController,
  });

  final TextEditingController descriptionController;

  String? _descriptionValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel(label: 'Description', isRequired: true),
        TextFormField(
          controller: descriptionController,
          decoration: const InputDecoration(
            hintText: 'Enter product description',
          ),
          maxLines: 5,
          maxLength: 500,
          validator: _descriptionValidator,
        ),
      ],
    );
  }
}
