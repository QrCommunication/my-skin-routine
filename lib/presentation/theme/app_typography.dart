import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  static TextTheme get textTheme {
    return TextTheme(
      displayLarge: const TextStyle(
        fontFamily: 'Outfit',
        fontWeight: FontWeight.w300,
        fontSize: 57,
        height: 1.12,
        letterSpacing: -0.25,
      ),
      displayMedium: const TextStyle(
        fontFamily: 'Outfit',
        fontWeight: FontWeight.w300,
        fontSize: 45,
        height: 1.16,
        letterSpacing: 0,
      ),
      displaySmall: const TextStyle(
        fontFamily: 'Outfit',
        fontWeight: FontWeight.w400,
        fontSize: 36,
        height: 1.22,
        letterSpacing: 0,
      ),
      headlineLarge: const TextStyle(
        fontFamily: 'Outfit',
        fontWeight: FontWeight.w600,
        fontSize: 32,
        height: 1.25,
        letterSpacing: 0,
      ),
      headlineMedium: const TextStyle(
        fontFamily: 'Outfit',
        fontWeight: FontWeight.w500,
        fontSize: 28,
        height: 1.29,
        letterSpacing: 0,
      ),
      headlineSmall: const TextStyle(
        fontFamily: 'Outfit',
        fontWeight: FontWeight.w500,
        fontSize: 24,
        height: 1.33,
        letterSpacing: 0,
      ),
      titleLarge: const TextStyle(
        fontFamily: 'Outfit',
        fontWeight: FontWeight.w500,
        fontSize: 22,
        height: 1.27,
        letterSpacing: 0,
      ),
      titleMedium: const TextStyle(
        fontFamily: 'DM Sans',
        fontWeight: FontWeight.w500,
        fontSize: 16,
        height: 1.5,
        letterSpacing: 0.15,
      ),
      titleSmall: const TextStyle(
        fontFamily: 'DM Sans',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.1,
      ),
      bodyLarge: const TextStyle(
        fontFamily: 'DM Sans',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 1.5,
        letterSpacing: 0.5,
      ),
      bodyMedium: const TextStyle(
        fontFamily: 'DM Sans',
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.25,
      ),
      bodySmall: const TextStyle(
        fontFamily: 'DM Sans',
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.4,
      ),
      labelLarge: const TextStyle(
        fontFamily: 'DM Sans',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.1,
      ),
      labelMedium: const TextStyle(
        fontFamily: 'DM Sans',
        fontWeight: FontWeight.w500,
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.5,
      ),
      labelSmall: const TextStyle(
        fontFamily: 'DM Sans',
        fontWeight: FontWeight.w500,
        fontSize: 11,
        height: 1.45,
        letterSpacing: 0.5,
      ),
    );
  }
}
