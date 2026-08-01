import 'package:my_store/core/dependency_injection/repository_providers.dart';
import 'package:my_store/features/splash/domain/usecases/check_app_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_usecase_provider.g.dart';

@riverpod
CheckAppStatusUseCase checkAppStatusUseCase(Ref ref) {
  return CheckAppStatusUseCase(
    appInfoRepository: ref.watch(appInfoRepositoryProvider),
    remoteConfigRepository: ref.watch(remoteConfigRepositoryProvider),
  );
}
