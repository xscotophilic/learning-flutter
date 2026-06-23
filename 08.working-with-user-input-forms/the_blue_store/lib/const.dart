import 'package:flutter/material.dart';

class Constants {
  // Name
  static String appName = "The Blue Store";

  static String mainFontName = '';
  static String secondaryFontName = '';

  static TextTheme themeText(
    Color headingColor,
    Color bodyTextColor,
  ) {
    return ThemeData.dark().textTheme.copyWith(
          // Heading Fonts
          headline3: TextStyle(
            fontFamily: mainFontName,
            fontSize: 24,
            color: headingColor,
          ),
          headline5: TextStyle(
            fontFamily: mainFontName,
            fontSize: 18,
            color: headingColor,
          ),
          headline6: TextStyle(
            fontFamily: mainFontName,
            fontSize: 16,
            color: headingColor,
          ),
          // Body Fonts
          bodyText1: TextStyle(
            fontFamily: mainFontName,
            fontSize: 14,
            color: bodyTextColor,
            fontWeight: FontWeight.normal,
          ),
          bodyText2: TextStyle(
            fontFamily: mainFontName,
            fontSize: 13,
            color: bodyTextColor,
            fontWeight: FontWeight.normal,
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
      textTheme: themeText(
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
      textTheme: themeText(
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

  static const kDefaultPaddin = 15.0;
}
