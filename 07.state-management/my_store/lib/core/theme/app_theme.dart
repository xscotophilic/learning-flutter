import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_consts.dart';

class AppGradients extends ThemeExtension<AppGradients> {
  const AppGradients({
    required this.bannerGradient,
    required this.cardGradient,
  });

  final Gradient bannerGradient;
  final Gradient cardGradient;

  @override
  AppGradients copyWith({Gradient? bannerGradient, Gradient? cardGradient}) {
    return AppGradients(
      bannerGradient: bannerGradient ?? this.bannerGradient,
      cardGradient: cardGradient ?? this.cardGradient,
    );
  }

  @override
  AppGradients lerp(ThemeExtension<AppGradients>? other, double t) {
    if (other is! AppGradients) return this;

    return AppGradients(
      bannerGradient: bannerGradient,
      cardGradient: cardGradient,
    );
  }
}

class AppTheme {
  static final Color _background = const Color(0xFF1A1712);
  static final Color _onBackground = const Color(0xFFF2EEE8);

  static final Color _primary = const Color(0xFFE8B84A);
  static final Color _onPrimary = const Color(0xFF343028);

  static final Color _secondary = const Color(0xFFE8324A);
  static final Color _onSecondary = const Color(0xFFF2EEE8);

  static final Color _drawer = const Color(0xFF1E1C16);

  static final Color _bannerGradientStart = const Color(0xFF332E24);
  static final Color _bannerGradientEnd = const Color(0xFF28221A);

  static final Color _cardGradientStart = const Color(0xFF2C2210);
  static final Color _cardGradientEnd = const Color(0xFF1A1408);

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
          bannerGradient: LinearGradient(
            colors: [_bannerGradientStart, _bannerGradientEnd],
          ),
          cardGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_cardGradientStart, _cardGradientEnd],
          ),
        ),
      ],

      textTheme: ThemeData.dark().textTheme.copyWith(
        displayLarge: const TextStyle(fontSize: 36),
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
        scrolledUnderElevation: 0,
      ),
      drawerTheme: DrawerThemeData(backgroundColor: _drawer),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: _onPrimary,
          minimumSize: const Size(0, 0),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConsts.defaultPadding / 2,
            vertical: AppConsts.defaultPadding / 2,
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConsts.defaultBorderRadius),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: _primary,
          side: BorderSide(color: _primary),
          minimumSize: const Size(0, 0),
          padding: const EdgeInsets.all(AppConsts.defaultPadding / 2),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textStyle: TextStyle(fontSize: 14, color: _primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConsts.defaultBorderRadius),
          ),
        ),
      ),
    );
  }
}
