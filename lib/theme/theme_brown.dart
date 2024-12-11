import "package:flutter/material.dart";

class MaterialThemeBrown {
  final TextTheme textTheme;

  const MaterialThemeBrown(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff8b4f25),
      surfaceTint: Color(0xff8b4f25),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffdbc7),
      onPrimaryContainer: Color(0xff311300),
      secondary: Color(0xff755846),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffdbc7),
      onSecondaryContainer: Color(0xff2b1709),
      tertiary: Color(0xff616134),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe7e6ad),
      onTertiaryContainer: Color(0xff1d1d00),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfffff8f5),
      onBackground: Color(0xff221a15),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff221a15),
      surfaceVariant: Color(0xfff4ded3),
      onSurfaceVariant: Color(0xff52443c),
      outline: Color(0xff84746a),
      outlineVariant: Color(0xffd7c3b8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382e29),
      inverseOnSurface: Color(0xffffede5),
      inversePrimary: Color(0xffffb689),
      primaryFixed: Color(0xffffdbc7),
      onPrimaryFixed: Color(0xff311300),
      primaryFixedDim: Color(0xffffb689),
      onPrimaryFixedVariant: Color(0xff6e380f),
      secondaryFixed: Color(0xffffdbc7),
      onSecondaryFixed: Color(0xff2b1709),
      secondaryFixedDim: Color(0xffe5bfa9),
      onSecondaryFixedVariant: Color(0xff5b4130),
      tertiaryFixed: Color(0xffe7e6ad),
      onTertiaryFixed: Color(0xff1d1d00),
      tertiaryFixedDim: Color(0xffcac993),
      onTertiaryFixedVariant: Color(0xff49491e),
      surfaceDim: Color(0xffe7d7cf),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1ea),
      surfaceContainer: Color(0xfffcebe2),
      surfaceContainerHigh: Color(0xfff6e5dc),
      surfaceContainerHighest: Color(0xfff0dfd7),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff69350b),
      surfaceTint: Color(0xff8b4f25),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffa66539),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff573d2d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff8d6e5b),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff45451b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff777748),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffff8f5),
      onBackground: Color(0xff221a15),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff221a15),
      surfaceVariant: Color(0xfff4ded3),
      onSurfaceVariant: Color(0xff4e4038),
      outline: Color(0xff6b5c53),
      outlineVariant: Color(0xff88776e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382e29),
      inverseOnSurface: Color(0xffffede5),
      inversePrimary: Color(0xffffb689),
      primaryFixed: Color(0xffa66539),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff884d23),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff8d6e5b),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff735644),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff777748),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff5e5e31),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe7d7cf),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1ea),
      surfaceContainer: Color(0xfffcebe2),
      surfaceContainerHigh: Color(0xfff6e5dc),
      surfaceContainerHighest: Color(0xfff0dfd7),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff3b1800),
      surfaceTint: Color(0xff8b4f25),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff69350b),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff331d0f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff573d2d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff232400),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff45451b),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffff8f5),
      onBackground: Color(0xff221a15),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xfff4ded3),
      onSurfaceVariant: Color(0xff2d211a),
      outline: Color(0xff4e4038),
      outlineVariant: Color(0xff4e4038),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382e29),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffffe7db),
      primaryFixed: Color(0xff69350b),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff4c2100),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff573d2d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3e2718),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff45451b),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff2e2e06),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe7d7cf),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1ea),
      surfaceContainer: Color(0xfffcebe2),
      surfaceContainerHigh: Color(0xfff6e5dc),
      surfaceContainerHighest: Color(0xfff0dfd7),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb689),
      surfaceTint: Color(0xffffb689),
      onPrimary: Color(0xff512400),
      primaryContainer: Color(0xff6e380f),
      onPrimaryContainer: Color(0xffffdbc7),
      secondary: Color(0xffe5bfa9),
      onSecondary: Color(0xff432b1c),
      secondaryContainer: Color(0xff5b4130),
      onSecondaryContainer: Color(0xffffdbc7),
      tertiary: Color(0xffcac993),
      onTertiary: Color(0xff323209),
      tertiaryContainer: Color(0xff49491e),
      onTertiaryContainer: Color(0xffe7e6ad),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff19120d),
      onBackground: Color(0xfff0dfd7),
      surface: Color(0xff19120d),
      onSurface: Color(0xfff0dfd7),
      surfaceVariant: Color(0xff52443c),
      onSurfaceVariant: Color(0xffd7c3b8),
      outline: Color(0xff9f8d83),
      outlineVariant: Color(0xff52443c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0dfd7),
      inverseOnSurface: Color(0xff382e29),
      inversePrimary: Color(0xff8b4f25),
      primaryFixed: Color(0xffffdbc7),
      onPrimaryFixed: Color(0xff311300),
      primaryFixedDim: Color(0xffffb689),
      onPrimaryFixedVariant: Color(0xff6e380f),
      secondaryFixed: Color(0xffffdbc7),
      onSecondaryFixed: Color(0xff2b1709),
      secondaryFixedDim: Color(0xffe5bfa9),
      onSecondaryFixedVariant: Color(0xff5b4130),
      tertiaryFixed: Color(0xffe7e6ad),
      onTertiaryFixed: Color(0xff1d1d00),
      tertiaryFixedDim: Color(0xffcac993),
      onTertiaryFixedVariant: Color(0xff49491e),
      surfaceDim: Color(0xff19120d),
      surfaceBright: Color(0xff413731),
      surfaceContainerLowest: Color(0xff140d08),
      surfaceContainerLow: Color(0xff221a15),
      surfaceContainer: Color(0xff261e19),
      surfaceContainerHigh: Color(0xff312823),
      surfaceContainerHighest: Color(0xff3d332d),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffbc93),
      surfaceTint: Color(0xffffb689),
      onPrimary: Color(0xff290f00),
      primaryContainer: Color(0xffc78051),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe9c3ad),
      onSecondary: Color(0xff251105),
      secondaryContainer: Color(0xffac8a76),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffcfce96),
      onTertiary: Color(0xff171700),
      tertiaryContainer: Color(0xff949361),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff19120d),
      onBackground: Color(0xfff0dfd7),
      surface: Color(0xff19120d),
      onSurface: Color(0xfffffaf8),
      surfaceVariant: Color(0xff52443c),
      onSurfaceVariant: Color(0xffdbc7bc),
      outline: Color(0xffb29f95),
      outlineVariant: Color(0xff918076),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0dfd7),
      inverseOnSurface: Color(0xff312823),
      inversePrimary: Color(0xff703910),
      primaryFixed: Color(0xffffdbc7),
      onPrimaryFixed: Color(0xff210b00),
      primaryFixedDim: Color(0xffffb689),
      onPrimaryFixedVariant: Color(0xff5a2801),
      secondaryFixed: Color(0xffffdbc7),
      onSecondaryFixed: Color(0xff1f0c02),
      secondaryFixedDim: Color(0xffe5bfa9),
      onSecondaryFixedVariant: Color(0xff493121),
      tertiaryFixed: Color(0xffe7e6ad),
      onTertiaryFixed: Color(0xff121200),
      tertiaryFixedDim: Color(0xffcac993),
      onTertiaryFixedVariant: Color(0xff38380f),
      surfaceDim: Color(0xff19120d),
      surfaceBright: Color(0xff413731),
      surfaceContainerLowest: Color(0xff140d08),
      surfaceContainerLow: Color(0xff221a15),
      surfaceContainer: Color(0xff261e19),
      surfaceContainerHigh: Color(0xff312823),
      surfaceContainerHighest: Color(0xff3d332d),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffffaf8),
      surfaceTint: Color(0xffffb689),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffbc93),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffffaf8),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffe9c3ad),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffffdd7),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffcfce96),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff19120d),
      onBackground: Color(0xfff0dfd7),
      surface: Color(0xff19120d),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff52443c),
      onSurfaceVariant: Color(0xfffffaf8),
      outline: Color(0xffdbc7bc),
      outlineVariant: Color(0xffdbc7bc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0dfd7),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff471e00),
      primaryFixed: Color(0xffffe1d0),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffbc93),
      onPrimaryFixedVariant: Color(0xff290f00),
      secondaryFixed: Color(0xffffe1d0),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffe9c3ad),
      onSecondaryFixedVariant: Color(0xff251105),
      tertiaryFixed: Color(0xffebeab1),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffcfce96),
      onTertiaryFixedVariant: Color(0xff171700),
      surfaceDim: Color(0xff19120d),
      surfaceBright: Color(0xff413731),
      surfaceContainerLowest: Color(0xff140d08),
      surfaceContainerLow: Color(0xff221a15),
      surfaceContainer: Color(0xff261e19),
      surfaceContainerHigh: Color(0xff312823),
      surfaceContainerHighest: Color(0xff3d332d),
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
