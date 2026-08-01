import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static const String _reset = '\x1B[0m';
  static const String _gray = '\x1B[90m';
  static const String _blue = '\x1B[34m';
  static const String _yellow = '\x1B[33m';
  static const String _red = '\x1B[31m';

  static void d(String message, {String tag = 'DEBUG'}) {
    _log(message, tag: tag, color: _gray, level: 500);
  }

  static void i(String message, {String tag = 'INFO'}) {
    _log(message, tag: tag, color: _blue, level: 800);
  }

  static void w(String message, {String tag = 'WARN'}) {
    _log(message, tag: tag, color: _yellow, level: 900);
  }

  static void e(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String tag = 'ERROR',
  }) {
    _log(
      message,
      tag: tag,
      color: _red,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void _log(
    String message, {
    required String tag,
    required String color,
    required int level,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode) return;

    final formattedMessage = '$color[$tag] $message$_reset';

    developer.log(
      formattedMessage,
      name: 'AppLogger',
      level: level,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
