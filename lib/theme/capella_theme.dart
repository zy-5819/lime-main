import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lime/theme/color_schemes.dart';

enum ThemeType {
  blue,
  purple,
  green,
  pink,
  brown,
  yellow,
}

extension ThemeColorExtension on ThemeType {
  String toText() {
    switch (this) {
      case ThemeType.purple:
        return '紫色';
      case ThemeType.green:
        return '绿色';
      case ThemeType.pink:
        return '粉色';
      case ThemeType.blue:
        return '蓝色';
      case ThemeType.brown:
        return '棕色';
      case ThemeType.yellow:
        return '黄色';
    }
  }

  Color toColor(Brightness brightness) {
    if (brightness == Brightness.light) {
      switch (this) {
        case ThemeType.purple:
          return PurpleTheme.lightColorScheme.primary;
        case ThemeType.green:
          return GreenTheme.lightColorScheme.primary;
        case ThemeType.pink:
          return PinkTheme.lightColorScheme.primary;
        case ThemeType.blue:
          return BlueTheme.lightColorScheme.primary;
        case ThemeType.brown:
          return BrownTheme.lightColorScheme.primary;
        case ThemeType.yellow:
          return YellowTheme.lightColorScheme.primary;
      }
    } else {
      switch (this) {
        case ThemeType.purple:
          return PurpleTheme.darkColorScheme.primary;
        case ThemeType.green:
          return GreenTheme.darkColorScheme.primary;
        case ThemeType.pink:
          return PinkTheme.darkColorScheme.primary;
        case ThemeType.blue:
          return BlueTheme.darkColorScheme.primary;
        case ThemeType.brown:
          return BrownTheme.darkColorScheme.primary;
        case ThemeType.yellow:
          return YellowTheme.darkColorScheme.primary;
      }
    }
  }
}

class CapellaTheme {
  CapellaTheme({
    this.themeColor = ThemeType.purple,
  }) {
    setTheme(themeColor);
  }
  final ThemeType themeColor;

  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  void setTheme(ThemeType themeColor) {
    _lightThemedata = _setLightTheme(themeColor);
    _darkThemeData = _setDarkTheme(themeColor);
  }

  ThemeData get lightThemeData => _lightThemedata;
  late ThemeData _lightThemedata;
  ThemeData get darkThemeData => _darkThemeData;
  late ThemeData _darkThemeData;

  ThemeData _setLightTheme(ThemeType themeColor) {
    switch (themeColor) {
      case ThemeType.purple:
        return themeData(PurpleTheme.lightColorScheme, _lightFocusColor);
      case ThemeType.green:
        return themeData(GreenTheme.lightColorScheme, _lightFocusColor);
      case ThemeType.pink:
        return themeData(PinkTheme.lightColorScheme, _lightFocusColor);
      case ThemeType.blue:
        return themeData(BlueTheme.lightColorScheme, _lightFocusColor);
      case ThemeType.brown:
        return themeData(BrownTheme.lightColorScheme, _lightFocusColor);
      case ThemeType.yellow:
        return themeData(YellowTheme.lightColorScheme, _lightFocusColor);
    }
  }

  ThemeData _setDarkTheme(ThemeType themeColor) {
    switch (themeColor) {
      case ThemeType.purple:
        return themeData(PurpleTheme.darkColorScheme, _darkFocusColor);
      case ThemeType.green:
        return themeData(GreenTheme.darkColorScheme, _darkFocusColor);
      case ThemeType.pink:
        return themeData(PinkTheme.darkColorScheme, _darkFocusColor);
      case ThemeType.blue:
        return themeData(BlueTheme.darkColorScheme, _darkFocusColor);
      case ThemeType.brown:
        return themeData(BrownTheme.darkColorScheme, _darkFocusColor);
      case ThemeType.yellow:
        return themeData(YellowTheme.darkColorScheme, _darkFocusColor);
    }
  }

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      cupertinoOverrideTheme:
          const CupertinoThemeData(textTheme: CupertinoTextThemeData()),
      colorScheme: colorScheme,
      textTheme: _textTheme,
      primaryColor: const Color(0xFF030303),
      appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.onPrimary,
          elevation: 0,
          iconTheme: IconThemeData(color: colorScheme.primary),
          titleTextStyle: TextStyle(
            fontSize: 22.sp,
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          )),
      // listTileTheme: const ListTileThemeData(horizontalTitleGap: 0),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary),
      iconTheme: IconThemeData(color: colorScheme.primary, size: 22.sp),
      canvasColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.titleMedium!.apply(color: _darkFillColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(colorScheme.secondaryContainer))),
      cardTheme: CardTheme(
          color: colorScheme.onPrimary,
          surfaceTintColor: colorScheme.onPrimary),
    );
  }

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;
  static final _textTheme = TextTheme(
    headlineMedium:
        GoogleFonts.montserrat(fontWeight: _bold, fontSize: 20.0.sp),
    bodySmall: GoogleFonts.oswald(fontWeight: _semiBold, fontSize: 16.0.sp),
    headlineSmall: GoogleFonts.oswald(fontWeight: _medium, fontSize: 16.0.sp),
    titleMedium: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 16.0.sp),
    labelSmall: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 12.0.sp),
    bodyLarge: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 14.0.sp),
    titleSmall: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 14.0.sp),
    bodyMedium: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 16.0.sp),
    titleLarge: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 16.0.sp),
    labelLarge:
        GoogleFonts.montserrat(fontWeight: _semiBold, fontSize: 14.0.sp),
  );
}
