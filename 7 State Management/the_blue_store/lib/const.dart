import 'package:flutter/material.dart';

class Constants {
  // Name
  static String appName = "The Blue Store";

  static String mainFontName = '';
  static String secondaryFontName = '';

  static TextTheme ThemeText(
    Color HeadingColor,
    Color BodyTextColor,
  ) {
    return ThemeData.dark().textTheme.copyWith(
          // Heading Fonts
          headline3: TextStyle(
            fontFamily: mainFontName,
            fontSize: 24,
            color: HeadingColor,
          ),
          headline5: TextStyle(
            fontFamily: mainFontName,
            fontSize: 18,
            color: HeadingColor,
          ),
          headline6: TextStyle(
            fontFamily: mainFontName,
            fontSize: 16,
            color: HeadingColor,
          ),
          // Body Fonts
          bodyText1: TextStyle(
            fontFamily: mainFontName,
            fontSize: 14,
            color: BodyTextColor,
          ),
          bodyText2: TextStyle(
            fontFamily: mainFontName,
            fontSize: 13,
            color: BodyTextColor,
          ),
        );
  }

  static Color darkBackground = Color(0xFF242423);
  static Color darkPrimary = Color(0xFF242423);
  static Color darkAccent = Color(0xFFffc300);
  static Color canvasColorDarkgrey = Color(0xFF242423);
  static Color textLightColor = Color(0xFFf4f3ee);

  static Color lightBackground = Colors.white;
  static Color lightPrimary = Colors.white;
  static Color lightAccent = Color(0xFF242423);
  static Color lightCanvasColor = Color(0xFFDEE4E7);
  static Color textDarkColor = Color(0xFF222222);

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      backgroundColor: lightBackground,
      scaffoldBackgroundColor: lightBackground,
      primaryColor: lightPrimary,
      accentColor: lightAccent,
      canvasColor: lightCanvasColor,
      textTheme: ThemeText(
        lightAccent,
        textDarkColor,
      ),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: lightAccent,
        ),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      backgroundColor: darkBackground,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: darkPrimary,
      accentColor: darkAccent,
      canvasColor: canvasColorDarkgrey,
      textTheme: ThemeText(
        darkAccent,
        textLightColor,
      ),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: darkAccent,
        ),
      ),
    );
  }
}
