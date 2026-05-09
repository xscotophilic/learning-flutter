import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store/core/consts/app_dimensions.dart';
import 'package:my_store/core/consts/app_strings.dart';
import 'package:my_store/features/home/presentation/pages/home_page.dart';
import 'package:my_store/features/splash/presentation/providers/splash_page_data_notifier.dart';
import 'package:my_store/shared/widgets/generic_progress_indicator.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final splashPageAsyncData = ref.watch(splashPageDataProvider);

    ref.listen(splashPageDataProvider, (previous, next) {
      if (!next.hasError && !next.isLoading && next.hasValue) {
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      }
    });

    return Scaffold(
      body: Center(
        child: splashPageAsyncData.when(
          loading: () {
            return const _SplashPageContent();
          },
          error: (_, _) {
            return const _SplashErrorView();
          },
          data: (_) {
            return const _SplashPageContent();
          },
        ),
      ),
    );
  }
}

class _SplashPageContent extends StatelessWidget {
  const _SplashPageContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.appName,
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppDimensions.defaultMargin * 1.5),
        const GenericProgressIndicator(),
      ],
    );
  }
}

class _SplashErrorView extends StatelessWidget {
  const _SplashErrorView();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Something went wrong',
          style: textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.defaultMargin / 2),
        Text(
          'Check your connection and try again.',
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.defaultMargin),
        ElevatedButton.icon(
          onPressed: () {
            SystemNavigator.pop();
          },
          icon: const Icon(Icons.close),
          label: const Text('Close App'),
        ),
      ],
    );
  }
}
