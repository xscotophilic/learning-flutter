import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store/core/consts/app_dimensions.dart';
import 'package:my_store/features/my_products/presentation/providers/my_products_notifier.dart';
import 'package:my_store/features/my_products/presentation/widgets/product_currency_field.dart';
import 'package:my_store/features/my_products/presentation/widgets/product_description_field.dart';
import 'package:my_store/features/my_products/presentation/widgets/product_image_field.dart';
import 'package:my_store/features/my_products/presentation/widgets/product_name_field.dart';
import 'package:my_store/features/my_products/presentation/widgets/product_price_and_discount_field.dart';
import 'package:my_store/features/product/domain/entities/price.dart';
import 'package:my_store/features/product/domain/entities/product.dart';
import 'package:my_store/features/product/presentation/providers/product_notifier.dart';
import 'package:my_store/shared/widgets/generic_error_view.dart';
import 'package:my_store/shared/widgets/generic_progress_indicator.dart';
import 'package:my_store/shared/widgets/loading_overlay.dart';
import 'package:my_store/shared/widgets/main_app_bar.dart';
import 'package:my_store/shared/widgets/primary_button.dart';

const _validCurrencies = ['USD', 'EUR', 'GBP'];

class ProductFormPage extends ConsumerWidget {
  const ProductFormPage({super.key, this.productId});

  static const routeName = '/product-form';

  final String? productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if ((productId ?? '').isEmpty) return const ProductForm();

    final productAsync = ref.watch(productProvider(productId ?? ''));
    return productAsync.when(
      skipLoadingOnRefresh: false,
      loading: () {
        return const Center(child: GenericProgressIndicator());
      },
      error: (Object error, StackTrace stackTrace) {
        return Center(
          child: GenericErrorView(
            onRetry: () => ref.invalidate(productProvider(productId ?? '')),
          ),
        );
      },
      data: (product) {
        if (product == null) {
          return const Center(child: Text('Product not found'));
        }

        return ProductForm(product: product);
      },
    );
  }
}

class ProductForm extends ConsumerStatefulWidget {
  const ProductForm({super.key, this.product});

  final Product? product;

  @override
  ConsumerState<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends ConsumerState<ProductForm> {
  final _formKey = GlobalKey<FormState>();

  String _selectedCurrency = '';
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;
  late final TextEditingController _discountController;
  late final TextEditingController _imageUrlController;

  Product? get _product => widget.product;

  @override
  void initState() {
    super.initState();

    _selectedCurrency = _product?.price.currency ?? _validCurrencies.first;
    _nameController = TextEditingController(text: _product?.name);
    _descriptionController = TextEditingController(text: _product?.description);
    _priceController = TextEditingController(
      text: _product?.price.amount.toString(),
    );
    _discountController = TextEditingController(
      text: _product?.price.discountPercent?.toString(),
    );
    _imageUrlController = TextEditingController(text: _product?.imageUrl);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final name = _nameController.text.trim();
    final amount = double.tryParse(_priceController.text.trim()) ?? 0.0;
    final discount = double.tryParse(_discountController.text.trim());
    final description = _descriptionController.text.trim();
    final imageUrl = _imageUrlController.text.trim();

    final product = Product(
      id: _product?.id ?? '',
      name: name,
      description: description,
      price: Price(
        amount: amount,
        discountPercent: discount,
        currency: _selectedCurrency,
      ),
      imageUrl: imageUrl,
      creatorId: _product?.creatorId ?? '',
    );

    final notifier = ref.read(myProductsProvider.notifier);
    if (product.id.isEmpty) {
      await notifier.createProduct(product);
    } else {
      await notifier.updateProduct(product);
    }
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.defaultPadding),
      child: SizedBox(
        width: double.infinity,
        child: PrimaryButton(
          text: _product != null ? 'Save Changes' : 'Create Product',
          icon: Icons.edit_note_outlined,
          onTap: _saveForm,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMutating = ref.watch(myProductsProvider).value?.isMutating ?? false;

    return Scaffold(
      appBar: MainAppBar(
        title: _product != null ? 'Edit Product' : 'Add Product',
        leadingIcon: Icons.arrow_back_ios_new,
        onLeadingTap: () {
          Navigator.pop(context);
        },
      ),
      body: LoadingOverlay(
        isLoading: isMutating,
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(AppDimensions.defaultPadding),
                    children: [
                      ProductNameField(nameController: _nameController),
                      const SizedBox(height: AppDimensions.defaultMargin),

                      ProductPriceAndDiscountField(
                        priceController: _priceController,
                        discountController: _discountController,
                      ),
                      const SizedBox(height: AppDimensions.defaultMargin),

                      ProductCurrencyField(
                        selectedCurrency: _selectedCurrency,
                        validCurrencies: _validCurrencies,
                        onCurrencySelected: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedCurrency = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: AppDimensions.defaultMargin),

                      ProductDescriptionField(
                        descriptionController: _descriptionController,
                      ),
                      const SizedBox(height: AppDimensions.defaultMargin),

                      ProductImageField(
                        imageUrlController: _imageUrlController,
                      ),
                      const SizedBox(height: AppDimensions.defaultMargin),
                    ],
                  ),
                ),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
