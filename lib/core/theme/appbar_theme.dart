import 'package:cart_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppAppbarTheme {
  static const AppBarTheme appBarTheme = AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.primary,
      elevation: 0,
      titleTextStyle: TextStyle(
          color: AppColors.primary, fontSize: 30, fontWeight: FontWeight.w600));
}
