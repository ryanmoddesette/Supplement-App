import 'package:flutter/material.dart';

class AppTheme {
  // Custom colors
  static const primaryYellow = Color(0xFFFFD700);
  static const darkBackground = Color(0xFF121212);
  static const surfaceColor = Color(0xFF1E1E1E);
  static const cardColor = Color(0xFF2C2C2C);
  static const successGreen = Color(0xFF4CAF50);
  static const warningYellow = Color(0xFFFFD700);
  static const errorRed = Color(0xFFE53935);

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: primaryYellow,
      secondary: primaryYellow.withOpacity(0.7),
      surface: surfaceColor,
      background: darkBackground,
      error: errorRed,
    ),
    scaffoldBackgroundColor: darkBackground,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: surfaceColor,
      foregroundColor: primaryYellow,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surfaceColor,
      selectedItemColor: primaryYellow,
      unselectedItemColor: Colors.grey,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: cardColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: primaryYellow,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryYellow,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade800),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryYellow),
      ),
      labelStyle: const TextStyle(color: Colors.grey),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
  );

  // We'll keep a light theme definition but won't use it since the app is dark mode only
  static final ThemeData lightTheme = darkTheme;
} 