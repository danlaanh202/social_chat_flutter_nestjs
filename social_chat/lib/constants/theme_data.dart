import 'social_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  primarySwatch: socialPrimarySwatch,
  scaffoldBackgroundColor: socialScaffoldBackgroundColor,
  primaryColor: socialPrimaryColor,
  primaryColorDark: socialTextPrimaryDark,
  brightness: socialBrightnessLight,
  fontFamily: GoogleFonts.openSans().fontFamily,
  colorScheme: const ColorScheme(
    brightness: socialBrightnessLight,
    primary: Colors.blue,
    onPrimary: Colors.white,
    secondary: Colors.grey,
    onSecondary: Colors.grey,
    error: Colors.grey,
    onError: Colors.grey,
    background: Colors.grey,
    onBackground: Colors.grey,
    surface: Colors.grey,
    onSurface: Colors.grey,
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.white,
  ),
);
final ThemeData darkTheme = ThemeData(
  primarySwatch: socialPrimarySwatchDark,
  scaffoldBackgroundColor: socialScaffoldBackgroundColorDark,
  primaryColor: socialPrimaryColorDark,
  fontFamily: GoogleFonts.openSans().fontFamily,
  brightness: socialBrightnessDark,
  colorScheme: const ColorScheme(
    brightness: socialBrightnessDark,
    surface: socialScaffoldBackgroundColorDark,
    onSurface: Colors.white,
    // not relevant to app bar in dark mode
    primary: Colors.blue,
    onPrimary: Colors.white,
    secondary: Colors.grey,
    onSecondary: Colors.grey,
    error: Colors.grey,
    onError: Colors.grey,
    background: Colors.grey,
    onBackground: Colors.grey,
  ),
  appBarTheme: const AppBarTheme(
    color: darkModeAppbarBackground,
  ),
);
