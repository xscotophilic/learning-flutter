import 'package:flutter/material.dart';

class AppConstants {
  // Name
  static String appName = 'Appetite Assorted';

  static final Color _primary = const Color(0xff0A2929);
  static final Color _onPrimary = const Color(0xfffcfcff);

  static final Color _secondary = const Color(0xFFE8A830);
  static final Color _onSecondary = const Color(0xfffcfcff);

  static final Color _background = const Color(0xFF071F1F);
  static final Color _onBackground = const Color(0xfffcfcff);

  static final double defaultPadding = 32.0;

  static ThemeData primaryTheme(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.light(
        surface: _background,
        onSurface: _onBackground,
        primary: _primary,
        onPrimary: _onPrimary,
        secondary: _secondary,
        onSecondary: _onSecondary,
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
        titleLarge: const TextStyle(fontSize: 24),
        titleMedium: const TextStyle(fontSize: 20),
        titleSmall: const TextStyle(fontSize: 16),
        bodyLarge: const TextStyle(fontSize: 14),
        bodyMedium: const TextStyle(fontSize: 12),
        bodySmall: const TextStyle(fontSize: 10),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _primary,
        foregroundColor: _onPrimary,
        iconTheme: IconThemeData(color: _onPrimary),
        titleTextStyle: TextStyle(fontSize: 24, color: _onPrimary),
      ),
      canvasColor: _background,
      scaffoldBackgroundColor: _background,
    );
  }
}
