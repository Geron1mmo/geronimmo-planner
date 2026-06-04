import 'package:flutter/material.dart';

class AppTheme {
  static const Color primarySeed = Color(0xFF3B82F6); // Nice blue

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: primarySeed,
    brightness: Brightness.light,
    cardTheme: const CardTheme(
      elevation: 1,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: primarySeed,
    brightness: Brightness.dark,
    cardTheme: const CardTheme(
      elevation: 1,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
  );

  static List<Color> accentColors = const [
    Color(0xFF3B82F6), // Blue
    Color(0xFF10B981), // Emerald
    Color(0xFF8B5CF6), // Violet
    Color(0xFFEF4444), // Red
    Color(0xFFF59E0B), // Amber
    Color(0xFFEC4899), // Pink
  ];
}
