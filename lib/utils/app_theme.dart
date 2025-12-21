import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    textTheme: TextTheme(headlineLarge: AppStyles.bold20Black),
    scaffoldBackgroundColor: AppColors.whiteBgColor,
  );

  static final ThemeData darkTheme = ThemeData(
    textTheme: TextTheme(headlineLarge: AppStyles.bold20White),
    scaffoldBackgroundColor: AppColors.primaryDark,
  );
}
