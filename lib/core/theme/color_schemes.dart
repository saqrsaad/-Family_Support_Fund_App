import 'package:flutter/material.dart';

class AppColorSchemes {
  static const Color primaryGold = Color(0xFFD4A373);
  static const Color secondaryOlive = Color(0xFF7F8C5A);
  static const Color surfaceLight = Color(0xFFFDFBF7);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  static ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primaryGold,
    onPrimary: Colors.white,
    primaryContainer: primaryGold.withOpacity(0.15),
    onPrimaryContainer: Color(0xFF5A3E1B),
    secondary: secondaryOlive,
    onSecondary: Colors.white,
    secondaryContainer: secondaryOlive.withOpacity(0.15),
    onSecondaryContainer: Color(0xFF2D361E),
    error: Color(0xFFBA1A1A),
    onError: Colors.white,
    surface: surfaceLight,
    onSurface: Color(0xFF1E1B16),
    surfaceContainerHighest: Color(0xFFEFE9DF),
    onSurfaceVariant: Color(0xFF4E463B),
    outline: Color(0xFF7A7266),
    shadow: Colors.black26,
  );

  static ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primaryGold,
    onPrimary: Colors.black87,
    primaryContainer: primaryGold.withOpacity(0.2),
    onPrimaryContainer: Color(0xFFFFE4C4),
    secondary: secondaryOlive,
    onSecondary: Colors.black87,
    secondaryContainer: secondaryOlive.withOpacity(0.2),
    onSecondaryContainer: Color(0xFFE1EEC0),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    surface: surfaceDark,
    onSurface: Color(0xFFE8E2D9),
    surfaceContainerHighest: Color(0xFF4A4238),
    onSurfaceVariant: Color(0xFFCFC4B6),
    outline: Color(0xFF968D81),
    shadow: Colors.black45,
  );
}