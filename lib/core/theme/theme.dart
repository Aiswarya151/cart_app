import 'package:cart_app/core/theme/app_button_theme.dart';
import 'package:cart_app/core/theme/app_colors.dart';
import 'package:cart_app/core/theme/appbar_theme.dart';
import 'package:cart_app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    appBarTheme: AppAppbarTheme.appBarTheme,
    elevatedButtonTheme: AppButtonTheme.elevatedButtonTheme,
    textTheme: AppTextTheme.textTheme,
  );
  static ThemeData darkTheme =
      ThemeData(brightness: Brightness.dark, primarySwatch: Colors.blue);
}
