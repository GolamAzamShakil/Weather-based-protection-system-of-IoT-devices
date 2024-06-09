import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    //background: Colors.grey.shade300,
    //primary: Colors.grey.shade200,
    //secondary: Colors.grey.shade400,
    //inversePrimary: Colors.grey.shade600,
    background: Color(0xfff9f9ff),
    primary: Color(0xff445e91),
    surfaceTint: Color(0xff445e91),
    onPrimary: Color(0xffffffff),
    primaryContainer: Color(0xffd8e2ff),
    onPrimaryContainer: Color(0xff001a41),
    secondary: Color(0xff575e71),
    onSecondary: Color(0xffffffff),
    secondaryContainer: Color(0xffdbe2f9),
    onSecondaryContainer: Color(0xff141b2c),
    tertiary: Color(0xff715573),
    onTertiary: Color(0xffffffff),
    tertiaryContainer: Color(0xfffbd7fc),
    onTertiaryContainer: Color(0xff29132d),
    error: Color(0xffba1a1a),
    onError: Color(0xffffffff),
    errorContainer: Color(0xffffdad6),
    onErrorContainer: Color(0xff410002),
    onBackground: Color(0xff1a1b20),
    surface: Color(0xfff9f9ff),
    onSurface: Color(0xff1a1b20),
    surfaceVariant: Color(0xffe1e2ec),
    onSurfaceVariant: Color(0xff44474f),
    outline: Color(0xff74777f),
    outlineVariant: Color(0xffc4c6d0),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xff2f3036),
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: const Color(0xff1a1b20),
       displayColor: const Color(0xff1a1b20),
      ),
);


ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    //background: Colors.grey.shade900,
    //primary: Colors.grey.shade800,
    //secondary: Colors.grey.shade700,
    //inversePrimary: Colors.grey.shade400,
    background: Color(0xff111318),
    primary: Color(0xffadc6ff),
    surfaceTint: Color(0xffadc6ff),
    onPrimary: Color(0xff102f60),
    primaryContainer: Color(0xff2b4678),
    onPrimaryContainer: Color(0xffd8e2ff),
    secondary: Color(0xffbfc6dc),
    onSecondary: Color(0xff293041),
    secondaryContainer: Color(0xff3f4759),
    onSecondaryContainer: Color(0xffdbe2f9),
    tertiary: Color(0xffdebcdf),
    onTertiary: Color(0xff402843),
    tertiaryContainer: Color(0xff583e5b),
    onTertiaryContainer: Color(0xfffbd7fc),
    error: Color(0xffffb4ab),
    onError: Color(0xff690005),
    errorContainer: Color(0xff93000a),
    onErrorContainer: Color(0xffffdad6),
    onBackground: Color(0xffe2e2e9),
    surface: Color(0xff111318),
    onSurface: Color(0xffe2e2e9),
    surfaceVariant: Color(0xff44474f),
    onSurfaceVariant: Color(0xffc4c6d0),
    outline: Color(0xff8e9099),
    outlineVariant: Color(0xff44474f),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xffe2e2e9),
  ),
  textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: const Color(0xffe2e2e9),
       displayColor: const Color(0xffe2e2e9),
      ),
);
