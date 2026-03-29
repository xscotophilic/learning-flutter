import 'package:flutter/material.dart';

class Constants {
  // Name
  static String appName = 'The Blue Store';

  static String mainFontName = '';
  static String secondaryFontName = '';

  static const kDefaultPadding = 16.0;

  static Color lightBackground = Colors.white;
  static Color lightPrimary = Colors.white;
  static Color lightAccent = const Color(0xFF242423);
  static Color lightCanvasColor = const Color(0xFFDEE4E7);

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.light(
        surface: lightBackground,
        onSurface: lightCanvasColor,
        primary: lightPrimary,
        onPrimary: lightCanvasColor,
        secondary: lightAccent,
        onSecondary: lightCanvasColor,
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
        titleLarge: const TextStyle(fontSize: 24),
        titleMedium: const TextStyle(fontSize: 20),
        titleSmall: const TextStyle(fontSize: 16),
        bodyLarge: const TextStyle(fontSize: 14),
        bodyMedium: const TextStyle(fontSize: 12),
        bodySmall: const TextStyle(fontSize: 10),
      ),
      appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: lightAccent)),
    );
  }
}
