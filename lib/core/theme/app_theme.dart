import 'package:flutter/material.dart';
import 'color_schemes.dart';
import 'text_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: AppColorSchemes.lightScheme,
    textTheme: AppTextTheme.lightTextTheme.apply(
      bodyColor: AppColorSchemes.lightScheme.onSurface,
      displayColor: AppColorSchemes.lightScheme.onSurface,
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shadowColor: AppColorSchemes.lightScheme.shadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        foregroundColor: AppColorSchemes.lightScheme.onPrimary,
        backgroundColor: AppColorSchemes.lightScheme.primary,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorSchemes.lightScheme.surfaceContainerHighest.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColorSchemes.lightScheme.outline, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColorSchemes.lightScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColorSchemes.lightScheme.error, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColorSchemes.lightScheme.surface,
      foregroundColor: AppColorSchemes.lightScheme.onSurface,
      titleTextStyle: AppTextTheme.lightTextTheme.titleLarge?.copyWith(
        color: AppColorSchemes.lightScheme.onSurface,
      ),
    ),
    iconTheme: IconThemeData(color: AppColorSchemes.lightScheme.primary, size: 24),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColorSchemes.lightScheme.surface,
      selectedItemColor: AppColorSchemes.lightScheme.primary,
      unselectedItemColor: AppColorSchemes.lightScheme.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    scaffoldBackgroundColor: AppColorSchemes.lightScheme.surface,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: AppColorSchemes.darkScheme,
    textTheme: AppTextTheme.darkTextTheme.apply(
      bodyColor: AppColorSchemes.darkScheme.onSurface,
      displayColor: AppColorSchemes.darkScheme.onSurface,
    ),
    cardTheme: CardThemeData(
      elevation: 4,
      shadowColor: AppColorSchemes.darkScheme.shadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        foregroundColor: AppColorSchemes.darkScheme.onPrimary,
        backgroundColor: AppColorSchemes.darkScheme.primary,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorSchemes.darkScheme.surfaceContainerHighest.withOpacity(0.4),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
        
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColorSchemes.darkScheme.outline, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColorSchemes.darkScheme.primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColorSchemes.darkScheme.surface,
      foregroundColor: AppColorSchemes.darkScheme.onSurface,
      titleTextStyle: AppTextTheme.darkTextTheme.titleLarge?.copyWith(
        color: AppColorSchemes.darkScheme.onSurface,
      ),
    ),
    iconTheme: IconThemeData(color: AppColorSchemes.darkScheme.primary, size: 24),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColorSchemes.darkScheme.surface,
      selectedItemColor: AppColorSchemes.darkScheme.primary,
      unselectedItemColor: AppColorSchemes.darkScheme.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    scaffoldBackgroundColor: AppColorSchemes.darkScheme.surface,
  );
}