import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_dimensions.dart';
import 'package:my_store/features/my_products/presentation/widgets/field_label.dart';
import 'package:my_store/shared/widgets/error_image_placeholder.dart';

class ProductImageField extends StatefulWidget {
  const ProductImageField({super.key, required this.imageUrlController});

  final TextEditingController imageUrlController;

  @override
  State<ProductImageField> createState() => _ProductImageFieldState();
}

class _ProductImageFieldState extends State<ProductImageField> {
  Timer? _debounceTimer;
  bool hasValidImageUrl = false;

  String get _imageUrl => widget.imageUrlController.text;

  @override
  void initState() {
    super.initState();
    widget.imageUrlController.addListener(_onImageUrlChanged);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    widget.imageUrlController.removeListener(_onImageUrlChanged);
    super.dispose();
  }

  void _onImageUrlChanged() {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 750), () {
      if (!mounted) return;

      final uri = Uri.tryParse(_imageUrl);

      setState(() {
        hasValidImageUrl = uri != null;
      });
    });
  }

  String? _validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Image URL is required';
    }
    if (Uri.tryParse(value) == null) {
      return 'Invalid image URL';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel(label: 'Product Image', isRequired: true),
        Row(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).inputDecorationTheme.fillColor,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.defaultBorderRadius,
                        ),
                        border: Border.all(
                          color: colorScheme.primary.withAlpha(200),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.cloud_upload_outlined,
                            size: AppDimensions.defaultIconSize * 1.25,
                          ),
                          const SizedBox(
                            height: AppDimensions.defaultMargin / 4,
                          ),
                          Text(
                            'Upload Disabled',
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.secondary,
                            ),
                          ),
                          const SizedBox(
                            height: AppDimensions.defaultMargin / 4,
                          ),
                          Text(
                            'Use Image URL instead',
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorScheme.surface.withAlpha(150),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.defaultBorderRadius,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.defaultMargin),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).inputDecorationTheme.fillColor,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.defaultBorderRadius,
                    ),
                    border: Border.all(
                      color: colorScheme.primary.withAlpha(200),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.defaultBorderRadius,
                    ),
                    child: _ImagePreview(
                      url: hasValidImageUrl ? _imageUrl : null,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.defaultMargin),

        const FieldLabel(label: 'Image URL', isRequired: true),
        TextFormField(
          controller: widget.imageUrlController,
          decoration: const InputDecoration(
            hintText: 'https://example.com/image.jpg',
            suffixIcon: Icon(Icons.link),
          ),
          validator: _validator,
        ),
      ],
    );
  }
}

class _ImagePreview extends StatelessWidget {
  const _ImagePreview({required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    if ((url ?? '').isEmpty) {
      return const Icon(
        Icons.image_outlined,
        size: AppDimensions.defaultIconSize * 1.25,
      );
    }
    return Image.network(
      url ?? '',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const ErrorImagePlaceholder(
          width: double.infinity,
          height: double.infinity,
        );
      },
    );
  }
}
