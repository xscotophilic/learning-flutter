import 'package:flutter/material.dart';

class AppConstants {
  // Name
  static String appName = "Appetite Assorted";

  static final Color _primary = Color(0xff57cc99);
  static final Color _darkgrey = Color(0xFF242423);

  static final Color _lightAccent = Color(0xfffcfcff);
  static final Color _lightBackground = Color(0xfffcfcff);

  static final Color _darkAccent = Color(0xFF3B72FF);
  static final Color _darkBackground = Colors.black;

  static final double defaultPadding = 32.0;

  static ThemeData lighTheme(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.light(
        surface: _lightBackground,
        primary: _primary,
        secondary: _lightAccent,
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
        titleLarge: TextStyle(fontSize: 18),
        titleMedium: TextStyle(fontSize: 16),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _darkBackground,
        foregroundColor: _lightAccent,
        iconTheme: IconThemeData(color: _lightAccent),
        titleTextStyle: TextStyle(fontSize: 24, color: _lightAccent),
      ),
      scaffoldBackgroundColor: _lightBackground,
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.light(
        surface: _darkBackground,
        primary: _primary,
        secondary: _darkAccent,
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
        titleLarge: TextStyle(fontSize: 18),
        titleMedium: TextStyle(fontSize: 16),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: _lightBackground,
        foregroundColor: _darkAccent,
        iconTheme: IconThemeData(color: _darkAccent),
        titleTextStyle: TextStyle(fontSize: 24, color: _darkAccent),
      ),
      canvasColor: _darkgrey,
      scaffoldBackgroundColor: _darkBackground,
    );
  }
}
