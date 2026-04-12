import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_consts.dart';

class AppGradients extends ThemeExtension<AppGradients> {
  const AppGradients({required this.cardGradient});

  final Gradient cardGradient;

  @override
  AppGradients copyWith({Gradient? cardGradient}) {
    return AppGradients(cardGradient: cardGradient ?? this.cardGradient);
  }

  @override
  AppGradients lerp(ThemeExtension<AppGradients>? other, double t) {
    if (other is! AppGradients) return this;

    return AppGradients(cardGradient: cardGradient);
  }
}

class AppTheme {
  static final Color _background = const Color(0xFF1A1712);
  static final Color _onBackground = const Color(0xFFF2EEE8);

  static final Color _primary = const Color(0xFFE8B84A);
  static final Color _onPrimary = const Color(0xFF343028);

  static final Color _secondary = const Color(0xFFE8324A);
  static final Color _onSecondary = const Color(0xFFF2EEE8);

  static final Color _gradientStart = const Color(0xFF211E18);
  static final Color _gradientEnd = const Color(0xFF2A2620);

  static ThemeData get primaryTheme {
    return ThemeData(
      canvasColor: _background,
      scaffoldBackgroundColor: _background,

      colorScheme: ColorScheme.dark(
        surface: _background,
        onSurface: _onBackground,
        primary: _primary,
        onPrimary: _onPrimary,
        secondary: _secondary,
        onSecondary: _onSecondary,
      ),
      extensions: [
        AppGradients(
          cardGradient: LinearGradient(colors: [_gradientStart, _gradientEnd]),
        ),
      ],

      textTheme: ThemeData.dark().textTheme.copyWith(
        titleLarge: const TextStyle(fontSize: 24),
        titleMedium: const TextStyle(fontSize: 20),
        titleSmall: const TextStyle(fontSize: 16),
        bodyLarge: const TextStyle(fontSize: 14),
        bodyMedium: const TextStyle(fontSize: 12),
        bodySmall: const TextStyle(fontSize: 10),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: _background,
        foregroundColor: _onBackground,
        iconTheme: IconThemeData(color: _onBackground),
        titleTextStyle: TextStyle(fontSize: 24, color: _onBackground),
      ),
      drawerTheme: DrawerThemeData(backgroundColor: _primary),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: _onPrimary,
          minimumSize: const Size(0, 0),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConsts.defaultPadding / 2,
            vertical: AppConsts.defaultPadding / 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConsts.defaultBorderRadius),
          ),
        ),
      ),
    );
  }
}
