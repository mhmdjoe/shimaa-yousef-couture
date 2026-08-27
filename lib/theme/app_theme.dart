import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryGold = Color(0xFFC5A059);
  static const Color charcoal = Color(0xFF1A1A1A);
  static const Color ivory = Color(0xFFF9F9F7);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGold,
        primary: primaryGold,
        secondary: charcoal,
        background: ivory,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.playfairDisplay(
          fontSize: 72,
          fontWeight: FontWeight.bold,
          color: charcoal,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: charcoal,
        ),
        bodyLarge: GoogleFonts.lato(
          fontSize: 18,
          color: charcoal.withOpacity(0.8),
        ),
        labelLarge: GoogleFonts.lato(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          color: primaryGold,
        ),
      ),
    );
  }
}
