import 'package:flutter/material.dart';
import 'package:my_store/features/my_products/presentation/widgets/field_label.dart';

class ProductNameField extends StatelessWidget {
  const ProductNameField({super.key, required this.nameController});

  final TextEditingController nameController;

  String? _nameValidator(String? value) {
    if ((value ?? '').trim().isEmpty) {
      return 'Product name is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel(label: 'Product name', isRequired: true),
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(hintText: 'Enter product name'),
          validator: _nameValidator,
        ),
      ],
    );
  }
}
