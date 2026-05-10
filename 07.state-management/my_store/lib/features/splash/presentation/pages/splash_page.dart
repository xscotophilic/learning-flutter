import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store/core/consts/app_dimensions.dart';
import 'package:my_store/features/home/presentation/pages/home_page.dart';
import 'package:my_store/features/splash/presentation/providers/splash_notifier.dart';
import 'package:my_store/features/splash/presentation/providers/splash_state.dart';
import 'package:my_store/features/splash/presentation/widgets/splash_error_view.dart';
import 'package:my_store/features/splash/presentation/widgets/splash_force_update_view.dart';
import 'package:my_store/features/splash/presentation/widgets/splash_maintenance_view.dart';
import 'package:my_store/features/splash/presentation/widgets/splash_page_content.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final splashPageAsyncData = ref.watch(splashProvider);

    ref.listen(splashProvider, (previous, next) {
      if (!next.hasError && !next.isLoading && next.hasValue) {
        final state = next.value;
        if (state is Success) {
          Navigator.of(context).pushReplacementNamed(HomePage.routeName);
        }
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.defaultMargin),
          child: splashPageAsyncData.when(
            loading: () {
              return const SplashPageContent();
            },
            error: (_, _) {
              return const SplashErrorView();
            },
            data: (state) {
              if (state is UnderMaintenance) {
                return SplashMaintenanceView(
                  message: state.message,
                  details: state.details,
                );
              }
              if (state is ForceUpdate) {
                return SplashForceUpdateView(
                  message: state.message,
                  details: state.details,
                );
              }
              return const SplashPageContent();
            },
          ),
        ),
      ),
    );
  }
}
