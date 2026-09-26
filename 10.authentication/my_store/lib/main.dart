import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store/core/consts/app_strings.dart';
import 'package:my_store/core/events/app_event.dart';
import 'package:my_store/core/events/event_bus.dart';
import 'package:my_store/core/routes/app_routes.dart';
import 'package:my_store/core/theme/app_theme.dart';
import 'package:my_store/core/utils/app_logger.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    AppLogger.e(
      'Flutter Framework Error',
      error: details.exception,
      stackTrace: details.stack,
    );
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    AppLogger.e('Unhandled Async Error', error: error, stackTrace: stackTrace);
    return true;
  };

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(ProviderScope(retry: (retryCount, error) => null, child: const App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  static final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  void _showSessionExpiredSnackBar() {
    _scaffoldMessengerKey.currentState?.clearSnackBars();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      const SnackBar(
        content: Text('Your session has expired. Please sign in again.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(eventBusProvider, (_, event) {
      if (event == null) return;

      switch (event) {
        case SessionExpiredEvent():
          _showSessionExpiredSnackBar();
      }

      ref.read(eventBusProvider.notifier).consume();
    });

    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme.primaryTheme,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
