import 'package:flutter/material.dart';

const _duration = Duration(seconds: 2);

final class AppSnackBar {
  static void _show(
    BuildContext context, {
    required String message,
    required Duration duration,
    required Color backgroundColor,
    required bool clearSnackBars,
  }) {
    if (clearSnackBars) {
      ScaffoldMessenger.of(context).clearSnackBars();
    }

    final snackBar = SnackBar(
      content: Text(message),
      duration: duration,
      backgroundColor: backgroundColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSuccessSnackBar(
    BuildContext context, {
    required String message,
    Duration duration = _duration,
    bool clearSnackBars = false,
  }) {
    _show(
      context,
      message: message,
      duration: duration,
      backgroundColor: Theme.of(context).colorScheme.primary,
      clearSnackBars: clearSnackBars,
    );
  }

  static void showErrorSnackBar(
    BuildContext context, {
    required String message,
    Duration duration = _duration,
    bool clearSnackBars = false,
  }) {
    _show(
      context,
      message: message,
      duration: duration,
      backgroundColor: Theme.of(context).colorScheme.error,
      clearSnackBars: clearSnackBars,
    );
  }
}
