import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  static TextTheme get lightTextTheme {
    return GoogleFonts.cairoTextTheme().copyWith(
      displayLarge: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      displayMedium: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      headlineLarge: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
      headlineMedium: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      titleLarge: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      titleMedium: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      bodyLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      bodyMedium: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      labelLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.5),
    );
  }

  static TextTheme get darkTextTheme {
    return lightTextTheme; // نفس الأحجام
  }
}