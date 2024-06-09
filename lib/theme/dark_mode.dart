import 'package:flutter/material.dart';

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
