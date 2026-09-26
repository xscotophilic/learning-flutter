// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_usecase_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(checkAppStatusUseCase)
final checkAppStatusUseCaseProvider = CheckAppStatusUseCaseProvider._();

final class CheckAppStatusUseCaseProvider
    extends
        $FunctionalProvider<
          CheckAppStatusUseCase,
          CheckAppStatusUseCase,
          CheckAppStatusUseCase
        >
    with $Provider<CheckAppStatusUseCase> {
  CheckAppStatusUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkAppStatusUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkAppStatusUseCaseHash();

  @$internal
  @override
  $ProviderElement<CheckAppStatusUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CheckAppStatusUseCase create(Ref ref) {
    return checkAppStatusUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CheckAppStatusUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CheckAppStatusUseCase>(value),
    );
  }
}

String _$checkAppStatusUseCaseHash() =>
    r'16cd90cfa55be818cd85c5282d2d2b0a8f49627a';
