import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_colors.dart';
import 'custom_text_style.dart';

/// TODO : define in theme data these fields
/// - appBarTheme
/// - progressIndicatorTheme
/// - inputDecorationTheme
class CustomTheme {
  //set your theme in MaterialApp
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: CustomColors.primaryColor,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: CustomColors.scaffoldBackGroundColor,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, titleTextStyle: CustomTextStyle.title),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        labelStyle: const TextStyle(
          fontSize: 12,
        ),
        hintStyle: const TextStyle(color: CustomColors.gray, fontSize: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: CustomColors.borderLightGrayColor,
            ),
            borderRadius: BorderRadius.circular(5)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.borderLightGrayColor),
            borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: CustomColors.primaryColor, width: 1.3),
            // borderSide: const BorderSide(width: 1.3),
            borderRadius: BorderRadius.circular(5)),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(CustomTextStyle.textThemeLight),
      buttonTheme: const ButtonThemeData(
          shape: RoundedRectangleBorder(
              side: BorderSide.none, borderRadius: BorderRadius.zero))
      // platform: TargetPlatform.iOS,
      );

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: CustomColors.primaryColor,
      backgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: CustomColors.primaryColor,
      ),
      textTheme: CustomTextStyle.textThemeDark);
}
