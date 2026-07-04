class MyProductsSnapshot {
  const MyProductsSnapshot({
    required this.isMutating,
    required this.productIds,
  });

  MyProductsSnapshot copyWith({bool? isMutating, List<String>? productIds}) {
    return MyProductsSnapshot(
      isMutating: isMutating ?? this.isMutating,
      productIds: productIds ?? this.productIds,
    );
  }

  final bool isMutating;
  final List<String> productIds;
}
