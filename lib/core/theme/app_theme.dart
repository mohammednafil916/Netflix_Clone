import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: GoogleFonts.poppins().fontFamily,

      primaryColor: AppColors.netflixRed,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primaryText,
        elevation: 0,
      ),

      colorScheme: ColorScheme.dark(
        primary: AppColors.netflixRed,
        surface: AppColors.surface,
      ),
    );
  }
}
