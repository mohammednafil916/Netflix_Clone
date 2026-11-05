import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,

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
