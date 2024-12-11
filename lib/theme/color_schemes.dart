import 'package:flutter/material.dart';
import 'package:lime/theme/capella_theme.dart';
import 'package:lime/theme/theme_brown.dart';
import 'package:lime/theme/theme_green.dart';
import 'package:lime/theme/theme_pink.dart';
import 'package:lime/theme/theme_purple.dart';
import 'package:lime/theme/theme_yellow.dart';

abstract class ColorTheme {
  static ColorScheme? lightColorScheme;
  static ColorScheme? darkColorScheme;
  ThemeType get color;
}

class PurpleTheme extends ColorTheme {
  @override
  ThemeType get color => ThemeType.purple;

  static final lightColorScheme =
      MaterialThemePurple.lightScheme().toColorScheme();

  static final darkColorScheme =
      MaterialThemePurple.darkScheme().toColorScheme();
}

class GreenTheme extends ColorTheme {
  @override
  ThemeType get color => ThemeType.green;

  static final lightColorScheme =
      MaterialThemeGreen.lightScheme().toColorScheme();

  static final darkColorScheme =
      MaterialThemeGreen.darkScheme().toColorScheme();
}

class PinkTheme extends ColorTheme {
  @override
  ThemeType get color => ThemeType.pink;
  static final lightColorScheme =
      MaterialThemePink.lightScheme().toColorScheme();

  static final darkColorScheme = MaterialThemePink.darkScheme().toColorScheme();
}

class BlueTheme extends ColorTheme {
  @override
  ThemeType get color => ThemeType.blue;

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF43BFFF),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFF3FBFF),
    onPrimaryContainer: Color(0xFF096898),
    secondary: Color(0xFF3C99C9),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFCEE3ED),
    onSecondaryContainer: Color(0xFF264460),
    tertiary: Color(0xFF7D5260),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFFD8E4),
    onTertiaryContainer: Color(0xFF31111D),
    error: Color(0xFFAE332C),
    errorContainer: Color(0xFFF9DEDC),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410E0B),
    surface: Color(0xFFFBFCFF),
    onSurface: Color(0xFF1C1B1F),
    surfaceContainerHighest: Color(0xFFD9D9D9),
    onSurfaceVariant: Color(0xFF4E4E4E),
    outline: Color(0xFF83888D),
    onInverseSurface: Color(0xFFE6F2FF),
    inverseSurface: Color(0xFF00344F),
    inversePrimary: Color(0xFF83CFFF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF00658E),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF83CFFF),
    onPrimary: Color(0xFF00344B),
    primaryContainer: Color(0xFF004C6C),
    onPrimaryContainer: Color(0xFFC6E7FF),
    secondary: Color(0xFF81CFFF),
    onSecondary: Color(0xFF00344B),
    secondaryContainer: Color(0xFF004C6B),
    onSecondaryContainer: Color(0xFFC6E7FF),
    tertiary: Color(0xFFFFB0CA),
    onTertiary: Color(0xFF5D1134),
    tertiaryContainer: Color(0xFF7A294B),
    onTertiaryContainer: Color(0xFFFFD9E3),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Color(0xFF001E30),
    onSurface: Color(0xFFCBE6FF),
    surfaceContainerHighest: Color(0xFF41484D),
    onSurfaceVariant: Color(0xFFC1C7CE),
    outline: Color(0xFF8B9198),
    onInverseSurface: Color(0xFF001E30),
    inverseSurface: Color(0xFFCBE6FF),
    inversePrimary: Color(0xFF00658E),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF83CFFF),
  );
}

class BrownTheme extends ColorTheme {
  @override
  ThemeType get color => ThemeType.brown;
  static final lightColorScheme =
      MaterialThemeBrown.lightScheme().toColorScheme();

  static final darkColorScheme =
      MaterialThemeBrown.darkScheme().toColorScheme();
}

class YellowTheme extends ColorTheme {
  @override
  ThemeType get color => ThemeType.yellow;

  static final lightColorScheme =
      MaterialThemeYellow.lightScheme().toColorScheme();

  static final darkColorScheme =
      MaterialThemeYellow.darkScheme().toColorScheme();
}
