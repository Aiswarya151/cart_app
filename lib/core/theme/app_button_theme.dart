import 'package:cart_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppButtonTheme {
  static final  ElevatedButtonThemeData elevatedButtonTheme=ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.background,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), 
      textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700),
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    )
  );
}