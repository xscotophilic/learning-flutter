import 'package:flutter/material.dart';

class Constants {
  // Name
  static String appName = "Appetite Assorted";

  // Material Design Color
  static Color lightPrimary = Color(0xff57cc99);
  static Color lightAccent = Color(0xfffcfcff);
  static Color lightBackground = Color(0xfffcfcff);

  static Color darkPrimary = Colors.black;
  static Color darkAccent = Color(0xFF3B72FF);
  static Color darkBackground = Colors.black;
  static Color darkgrey = Color(0xFF242423);
  static Color textDarkPrimary = Color(0xFFf4f3ee);

  static Color grey = Color(0xff707070);
  static Color textPrimary = Color(0xFF486581);
  static Color textDark = Color(0xFF102A43);

  static Color backgroundColor = Color(0xFFF5F5F7);

  // Green
  static Color darkGreen = Color(0xFF3ABD6F);
  static Color lightGreen = Color(0xFFA1ECBF);

  // Yellow
  static Color darkYellow = Color(0xFF3ABD6F);
  static Color lightYellow = Color(0xFFFFDA7A);

  // Blue
  static Color darkBlue = Color(0xFF3B72FF);
  static Color lightBlue = Color(0xFF3EC6FF);

  // Orange
  static Color darkOrange = Color(0xFFFFB74D);

  static String mainFontName = 'VisiaPro';

  static ThemeData lighTheme(BuildContext context) {
    return ThemeData(
      backgroundColor: lightBackground,
      scaffoldBackgroundColor: lightBackground,
      primaryColor: lightPrimary,
      accentColor: lightAccent,
      textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: mainFontName,
              fontSize: 18,
            ),
            headline5: TextStyle(
              fontFamily: mainFontName,
              fontSize: 16,
            ),
          ),
      appBarTheme: AppBarTheme(
        textTheme: ThemeData.dark().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: mainFontName,
                fontSize: 24,
                color: lightAccent,
              ),
            ),
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
      canvasColor: darkgrey,
      textTheme: ThemeData.dark().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: mainFontName,
              fontSize: 18,
              color: textDarkPrimary,
            ),
            headline5: TextStyle(
              fontFamily: mainFontName,
              fontSize: 15,
              color: textDarkPrimary,
            ),
            headline3: TextStyle(
              fontFamily: mainFontName,
              fontSize: 24,
              color: textDarkPrimary,
            ),
          ),
      appBarTheme: AppBarTheme(
        textTheme: ThemeData.dark().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: mainFontName,
                fontSize: 24,
                color: lightAccent,
              ),
            ),
        iconTheme: IconThemeData(
          color: darkAccent,
        ),
      ),
    );
  }

  static double headerHeight = 228.5;
  static double paddingSide = 30.0;
}
