import 'package:flutter/material.dart';
import '../../core/app_export.dart';


class ThemeHelper {
  PrimaryColors _getThemeColors() {
    return  PrimaryColors();
  }

  ThemeData _getThemeData() {
    var colorScheme = ColorSchemes.primaryColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      useMaterial3: true,
      textTheme: TextThemes.textTheme(colorScheme),
    );
  }

  PrimaryColors themeColor() => _getThemeColors();

  ThemeData themeData() => _getThemeData();
}

class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: appTheme.white.withOpacity(0.53),
          fontSize: 17.fSize,
          fontFamily: 'Sofia Pro',
          fontWeight: FontWeight.w400,
        ),
        displayMedium: TextStyle(
          color: appTheme.white,
          fontSize: 50.fSize,
          fontFamily: 'Taviraj',
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: TextStyle(
          color: appTheme.white,
          fontSize: 25.fSize,
          fontFamily: 'Sofia Pro',
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          color: appTheme.white,
          fontSize: 22.fSize,
          fontFamily: 'Sofia Pro',
          fontWeight: FontWeight.w400,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final primaryColorScheme = ColorScheme.light();
}

class PrimaryColors {

  Color get black77 => Color(0X77000000);
  Color get blueGray333 => Color(0XFF333333);
  Color get gray200 => Color(0XFFEAEAEA);

  Color get grayC2 => Color(0XFFC2C2C2);
  Color get red700 => Color(0XFFD13C3C);
  Color get white => Color(0XFFFFFFFF);
}

PrimaryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();
