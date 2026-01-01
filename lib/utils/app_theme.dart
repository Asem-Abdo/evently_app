import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    focusColor: AppColors.whiteColor,
    primaryColor: AppColors.primaryLight,
    iconTheme: IconThemeData(color: AppColors.blackColor),
    textTheme: TextTheme(
      titleLarge: AppStyles.medium16Black,
      headlineLarge: AppStyles.bold20Black,
      headlineMedium: AppStyles.medium16Primary,
      headlineSmall: AppStyles.medium16White,
      titleMedium: AppStyles.medium16Grey,
    ),
    scaffoldBackgroundColor: AppColors.whiteBgColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryLight,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.whiteColor,
      unselectedItemColor: AppColors.whiteColor,
      showUnselectedLabels: true,
      selectedLabelStyle: AppStyles.bold12White,
      unselectedLabelStyle: AppStyles.bold12White,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(35),
        side: BorderSide(color: AppColors.whiteColor, width: 5),
      ),
      backgroundColor: AppColors.primaryLight,
    ),
    appBarTheme: AppBarTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    focusColor: AppColors.primaryLight,
    primaryColor: AppColors.primaryDark,
    iconTheme: IconThemeData(color: AppColors.whiteColor),
    textTheme: TextTheme(
      titleLarge: AppStyles.medium16White,
      titleMedium: AppStyles.medium16White,
      headlineLarge: AppStyles.bold20White.copyWith(color: AppColors.goldColor),
      headlineMedium: AppStyles.medium16White.copyWith(
        color: AppColors.goldColor,
      ),
      headlineSmall: AppStyles.medium16White,
    ),
    scaffoldBackgroundColor: AppColors.primaryDark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryDark,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.goldColor,
      unselectedItemColor: AppColors.goldColor,
      showUnselectedLabels: true,
      selectedLabelStyle: AppStyles.bold12Gold,
      unselectedLabelStyle: AppStyles.bold12Gold,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(35),
        side: BorderSide(color: AppColors.whiteColor, width: 5),
      ),
      backgroundColor: AppColors.primaryLight,
    ),
    appBarTheme: AppBarTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    ),
  );
}
