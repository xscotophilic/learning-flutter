import 'package:flutter/material.dart';

class AppConstants {
  // Name
  static String appName = "Appetite Assorted";

  static final Color _primary = Color(0xff57cc99);
  static final Color _onPrimary = Color(0xfffcfcff);

  static final Color _lightBackground = Color(0xfffcfcff);
  static final Color _darkBackground = Color(0xFF495057);

  static final double defaultPadding = 32.0;

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.light(
        surface: _lightBackground,
        onSurface: _darkBackground,
        primary: _primary,
        onPrimary: _onPrimary,
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
        titleLarge: TextStyle(fontSize: 18),
        titleMedium: TextStyle(fontSize: 16),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _primary,
        foregroundColor: _onPrimary,
        iconTheme: IconThemeData(color: _onPrimary),
        titleTextStyle: TextStyle(fontSize: 24, color: _onPrimary),
      ),
      scaffoldBackgroundColor: _lightBackground,
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.light(
        surface: _darkBackground,
        onSurface: _lightBackground,
        primary: _primary,
        onPrimary: _onPrimary,
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
        titleLarge: TextStyle(fontSize: 24),
        titleMedium: TextStyle(fontSize: 20),
        titleSmall: TextStyle(fontSize: 16),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _primary,
        foregroundColor: _onPrimary,
        iconTheme: IconThemeData(color: _onPrimary),
        titleTextStyle: TextStyle(fontSize: 24, color: _onPrimary),
      ),
      canvasColor: _darkBackground,
      scaffoldBackgroundColor: _darkBackground,
    );
  }
}
