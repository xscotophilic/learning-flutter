import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_dimensions.dart';

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

  static final Color _secondary = const Color(0xFFE04F5F);
  static final Color _onSecondary = const Color(0xFFF2EEE8);

  static final Color _tertiary = const Color(0xFF1B8A5A);
  static final Color _onTertiary = const Color(0xFFF2EEE8);

  static final Color _drawer = const Color(0xFF1E1C16);

  static final Color _bannerGradientStart = const Color(0xFF332E24);
  static final Color _bannerGradientEnd = const Color(0xFF28221A);

  static final Color _cardGradientStart = const Color(0xFF2C2210);
  static final Color _cardGradientEnd = const Color(0xFF1A1408);

  static ThemeData get primaryTheme {
    return ThemeData(
      canvasColor: _background,
      scaffoldBackgroundColor: _background,
      visualDensity: VisualDensity.standard,
      colorScheme: ColorScheme.dark(
        surface: _background,
        onSurface: _onBackground,
        primary: _primary,
        onPrimary: _onPrimary,
        secondary: _secondary,
        onSecondary: _onSecondary,
        tertiary: _tertiary,
        onTertiary: _onTertiary,
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
        displayMedium: const TextStyle(fontSize: 28),
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
          padding: const EdgeInsets.all(AppDimensions.defaultPadding / 2),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.defaultBorderRadius,
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: _primary,
          side: BorderSide(color: _primary),
          minimumSize: const Size(0, 0),
          padding: const EdgeInsets.all(AppDimensions.defaultPadding / 3),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.defaultBorderRadius,
            ),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        isDense: true,
        fillColor: _onBackground.withAlpha(20),
        hintStyle: TextStyle(color: _onBackground.withAlpha(150)),
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppDimensions.defaultPadding / 2,
          horizontal: AppDimensions.defaultPadding / 3,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.defaultBorderRadius,
          ),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.defaultBorderRadius,
          ),
          borderSide: BorderSide(color: _primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.defaultBorderRadius,
          ),
          borderSide: BorderSide(color: _secondary.withAlpha(200)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.defaultBorderRadius,
          ),
          borderSide: BorderSide(color: _secondary),
        ),
      ),
    );
  }
}
