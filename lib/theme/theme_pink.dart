import "package:flutter/material.dart";

class MaterialThemePink {
  final TextTheme textTheme;

  const MaterialThemePink(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff8e4958),
      surfaceTint: Color(0xff8e4958),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffd9de),
      onPrimaryContainer: Color(0xff3a0717),
      secondary: Color(0xff75565b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffd9de),
      onSecondaryContainer: Color(0xff2b1519),
      tertiary: Color(0xff7a5832),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffdcbb),
      onTertiaryContainer: Color(0xff2c1700),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfffff8f7),
      onBackground: Color(0xff22191b),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff22191b),
      surfaceVariant: Color(0xfff3dde0),
      onSurfaceVariant: Color(0xff524345),
      outline: Color(0xff847375),
      outlineVariant: Color(0xffd6c2c4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382e2f),
      inverseOnSurface: Color(0xfffeedee),
      inversePrimary: Color(0xffffb2bf),
      primaryFixed: Color(0xffffd9de),
      onPrimaryFixed: Color(0xff3a0717),
      primaryFixedDim: Color(0xffffb2bf),
      onPrimaryFixedVariant: Color(0xff713341),
      secondaryFixed: Color(0xffffd9de),
      onSecondaryFixed: Color(0xff2b1519),
      secondaryFixedDim: Color(0xffe4bdc2),
      onSecondaryFixedVariant: Color(0xff5c3f44),
      tertiaryFixed: Color(0xffffdcbb),
      onTertiaryFixed: Color(0xff2c1700),
      tertiaryFixedDim: Color(0xffebbe90),
      onTertiaryFixedVariant: Color(0xff5f401d),
      surfaceDim: Color(0xffe7d6d7),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0f1),
      surfaceContainer: Color(0xfffbeaeb),
      surfaceContainerHigh: Color(0xfff5e4e6),
      surfaceContainerHighest: Color(0xfff0dee0),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff6c2f3d),
      surfaceTint: Color(0xff8e4958),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffa85f6e),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff573b40),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff8d6c71),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff5b3c19),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff926d46),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffff8f7),
      onBackground: Color(0xff22191b),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff22191b),
      surfaceVariant: Color(0xfff3dde0),
      onSurfaceVariant: Color(0xff4e3f41),
      outline: Color(0xff6b5b5d),
      outlineVariant: Color(0xff887679),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382e2f),
      inverseOnSurface: Color(0xfffeedee),
      inversePrimary: Color(0xffffb2bf),
      primaryFixed: Color(0xffa85f6e),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff8b4756),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff8d6c71),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff735459),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff926d46),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff775530),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe7d6d7),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0f1),
      surfaceContainer: Color(0xfffbeaeb),
      surfaceContainerHigh: Color(0xfff5e4e6),
      surfaceContainerHighest: Color(0xfff0dee0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff430e1d),
      surfaceTint: Color(0xff8e4958),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6c2f3d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff331b20),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff573b40),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff351d00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff5b3c19),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffff8f7),
      onBackground: Color(0xff22191b),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xfff3dde0),
      onSurfaceVariant: Color(0xff2d2123),
      outline: Color(0xff4e3f41),
      outlineVariant: Color(0xff4e3f41),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382e2f),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffffe6e9),
      primaryFixed: Color(0xff6c2f3d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff511927),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff573b40),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3f262a),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff5b3c19),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff412705),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe7d6d7),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0f1),
      surfaceContainer: Color(0xfffbeaeb),
      surfaceContainerHigh: Color(0xfff5e4e6),
      surfaceContainerHighest: Color(0xfff0dee0),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb2bf),
      surfaceTint: Color(0xffffb2bf),
      onPrimary: Color(0xff561d2b),
      primaryContainer: Color(0xff713341),
      onPrimaryContainer: Color(0xffffd9de),
      secondary: Color(0xffe4bdc2),
      onSecondary: Color(0xff43292e),
      secondaryContainer: Color(0xff5c3f44),
      onSecondaryContainer: Color(0xffffd9de),
      tertiary: Color(0xffebbe90),
      onTertiary: Color(0xff462a08),
      tertiaryContainer: Color(0xff5f401d),
      onTertiaryContainer: Color(0xffffdcbb),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff191113),
      onBackground: Color(0xfff0dee0),
      surface: Color(0xff191113),
      onSurface: Color(0xfff0dee0),
      surfaceVariant: Color(0xff524345),
      onSurfaceVariant: Color(0xffd6c2c4),
      outline: Color(0xff9f8c8e),
      outlineVariant: Color(0xff524345),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0dee0),
      inverseOnSurface: Color(0xff382e2f),
      inversePrimary: Color(0xff8e4958),
      primaryFixed: Color(0xffffd9de),
      onPrimaryFixed: Color(0xff3a0717),
      primaryFixedDim: Color(0xffffb2bf),
      onPrimaryFixedVariant: Color(0xff713341),
      secondaryFixed: Color(0xffffd9de),
      onSecondaryFixed: Color(0xff2b1519),
      secondaryFixedDim: Color(0xffe4bdc2),
      onSecondaryFixedVariant: Color(0xff5c3f44),
      tertiaryFixed: Color(0xffffdcbb),
      onTertiaryFixed: Color(0xff2c1700),
      tertiaryFixedDim: Color(0xffebbe90),
      onTertiaryFixedVariant: Color(0xff5f401d),
      surfaceDim: Color(0xff191113),
      surfaceBright: Color(0xff413738),
      surfaceContainerLowest: Color(0xff140c0d),
      surfaceContainerLow: Color(0xff22191b),
      surfaceContainer: Color(0xff261d1f),
      surfaceContainerHigh: Color(0xff312829),
      surfaceContainerHighest: Color(0xff3c3234),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb8c4),
      surfaceTint: Color(0xffffb2bf),
      onPrimary: Color(0xff330312),
      primaryContainer: Color(0xffc87a89),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe9c1c7),
      onSecondary: Color(0xff251014),
      secondaryContainer: Color(0xffab888d),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff0c294),
      onTertiary: Color(0xff241200),
      tertiaryContainer: Color(0xffb1895f),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff191113),
      onBackground: Color(0xfff0dee0),
      surface: Color(0xff191113),
      onSurface: Color(0xfffff9f9),
      surfaceVariant: Color(0xff524345),
      onSurfaceVariant: Color(0xffdbc6c8),
      outline: Color(0xffb19ea0),
      outlineVariant: Color(0xff917f81),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0dee0),
      inverseOnSurface: Color(0xff312829),
      inversePrimary: Color(0xff733442),
      primaryFixed: Color(0xffffd9de),
      onPrimaryFixed: Color(0xff2c000d),
      primaryFixedDim: Color(0xffffb2bf),
      onPrimaryFixedVariant: Color(0xff5d2231),
      secondaryFixed: Color(0xffffd9de),
      onSecondaryFixed: Color(0xff1f0b0f),
      secondaryFixedDim: Color(0xffe4bdc2),
      onSecondaryFixedVariant: Color(0xff492f34),
      tertiaryFixed: Color(0xffffdcbb),
      onTertiaryFixed: Color(0xff1d0e00),
      tertiaryFixedDim: Color(0xffebbe90),
      onTertiaryFixedVariant: Color(0xff4c300e),
      surfaceDim: Color(0xff191113),
      surfaceBright: Color(0xff413738),
      surfaceContainerLowest: Color(0xff140c0d),
      surfaceContainerLow: Color(0xff22191b),
      surfaceContainer: Color(0xff261d1f),
      surfaceContainerHigh: Color(0xff312829),
      surfaceContainerHighest: Color(0xff3c3234),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffff9f9),
      surfaceTint: Color(0xffffb2bf),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffb8c4),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffff9f9),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffe9c1c7),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffffaf8),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xfff0c294),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff191113),
      onBackground: Color(0xfff0dee0),
      surface: Color(0xff191113),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff524345),
      onSurfaceVariant: Color(0xfffff9f9),
      outline: Color(0xffdbc6c8),
      outlineVariant: Color(0xffdbc6c8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0dee0),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff4d1625),
      primaryFixed: Color(0xffffdfe3),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb8c4),
      onPrimaryFixedVariant: Color(0xff330312),
      secondaryFixed: Color(0xffffdfe3),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffe9c1c7),
      onSecondaryFixedVariant: Color(0xff251014),
      tertiaryFixed: Color(0xffffe2c7),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xfff0c294),
      onTertiaryFixedVariant: Color(0xff241200),
      surfaceDim: Color(0xff191113),
      surfaceBright: Color(0xff413738),
      surfaceContainerLowest: Color(0xff140c0d),
      surfaceContainerLow: Color(0xff22191b),
      surfaceContainer: Color(0xff261d1f),
      surfaceContainerHigh: Color(0xff312829),
      surfaceContainerHighest: Color(0xff3c3234),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
