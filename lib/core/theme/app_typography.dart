// lib/core/theme/app_typography.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextTheme getLightTextTheme() {
    return TextTheme(
      displayLarge: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: -1.0),
      displayMedium: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -0.5),
      displaySmall: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600),
      headlineMedium: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
      titleLarge: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      titleSmall: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
      bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.normal),
      bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.normal),
      bodySmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.normal),
      labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
      labelSmall: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w500),
    );
  }

  static TextTheme getDarkTextTheme() {
    return getLightTextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    );
  }
}
