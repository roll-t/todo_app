import 'package:flutter/material.dart';
import 'package:todo_app/core/themes/app_colors.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    primaryColorDark: AppColors.primaryColorDark,
    primaryColorLight: AppColors.primaryColorLight,
    secondaryHeaderColor: AppColors.secondaryColor,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.whiteColor,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textColor, fontSize: 16),
      bodyMedium: TextStyle(color: AppColors.textSecondaryColor, fontSize: 14),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      hintStyle: const TextStyle(
          fontWeight: FontWeight.w300, color: Color(0xff383838)),
      contentPadding: const EdgeInsets.all(25),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.black, width: .5)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.black, width: .5)),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primaryColor, // Default button color
      disabledColor: AppColors.textButtonDisabledColor,
    ),
    dividerColor: AppColors.dividerColor,
    iconTheme: const IconThemeData(
      color: AppColors.iconColor,
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColorDark,
    primaryColorDark: AppColors.primaryColorDark,
    primaryColorLight: AppColors.primaryColorLight,
    secondaryHeaderColor: AppColors.secondaryColor,
    scaffoldBackgroundColor: AppColors.blackColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColorDark,
      foregroundColor: AppColors.whiteColor,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textColor, fontSize: 16),
      bodyMedium: TextStyle(color: AppColors.textSecondaryColor, fontSize: 14),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      hintStyle: const TextStyle(
          fontWeight: FontWeight.w300, color: Color(0xff383838)),
      contentPadding: const EdgeInsets.all(25),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.black, width: .5)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.black, width: .5)),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primaryColorDark,
      disabledColor: AppColors.textButtonDisabledColor,
    ),
    dividerColor: AppColors.dividerColor,
    iconTheme: const IconThemeData(
      color: AppColors.whiteColor,
    ),
  );
}
