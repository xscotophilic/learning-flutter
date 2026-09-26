enum MyProductsMutationStatus { idle, mutating, success }

class MyProductsSnapshot {
  const MyProductsSnapshot({
    required this.productIds,
    this.mutationStatus = MyProductsMutationStatus.idle,
  });

  MyProductsSnapshot copyWith({
    List<String>? productIds,
    MyProductsMutationStatus? mutationStatus,
  }) {
    return MyProductsSnapshot(
      productIds: productIds ?? this.productIds,
      mutationStatus: mutationStatus ?? this.mutationStatus,
    );
  }

  final List<String> productIds;
  final MyProductsMutationStatus mutationStatus;

  bool get isMutating => mutationStatus == MyProductsMutationStatus.mutating;
  bool get isSuccess => mutationStatus == MyProductsMutationStatus.success;
}
