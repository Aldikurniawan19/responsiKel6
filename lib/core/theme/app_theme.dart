import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      primaryColor: AppColors.primary,
      textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
        headlineSmall: GoogleFonts.plusJakartaSans(
          color: AppColors.lightTextTitle,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          color: AppColors.lightTextBody,
          height: 1.5,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      primaryColor: AppColors.primary,
      textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
        headlineSmall: GoogleFonts.plusJakartaSans(
          color: AppColors.darkTextTitle,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          color: AppColors.darkTextBody,
          height: 1.5,
        ),
      ),
    );
  }
}