import 'package:flutter/material.dart';
/// Defines the app's theme using Material Design 3.
/// Keeping it separate from app.dart makes it easier to add 
/// features like dark mode and custom fonts later without 
/// changing the app's core logic.
class AppTheme {
  AppTheme._(); // This class cannot be created as an object because it only contains static members

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF4F46E5), // Indigo - modern student app feel
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      scaffoldBackgroundColor: const Color(0xFFF8F9FC),
    );
  }
}