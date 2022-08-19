import 'package:flutter/material.dart';

class CustomTextStyle {
  //add your text style here


  static const String fontName = 'WorkSans';


  static const TextTheme textThemeLight = TextTheme(
    subtitle2: display1Light,
    headline1: headline,
    headline2: title,
    subtitle1: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );
  static const TextTheme textThemeDark = TextTheme(
    subtitle2: display1Dark,
    headline1: headline,
    headline2: title,
    subtitle1: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1Light = TextStyle(
    // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: Colors.black,
  );

  static const TextStyle display1Dark = TextStyle(
    // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: Colors.black,
  );

  static const TextStyle headline = TextStyle(
    // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: Colors.black,
  );

  static const TextStyle title = TextStyle(
    // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: Colors.black,
  );

  static const TextStyle subtitle = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: Colors.black,
  );

  static const TextStyle body2 = TextStyle(
    // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: Colors.black,
  );

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.05,
    color: Colors.black,
  );

  static const TextStyle caption = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: Colors.black,
  );


  static const TextStyle titleBlueColor = TextStyle(
    color: Colors.blue,
    fontSize: 17,
    fontWeight: FontWeight.bold
  );

  static const TextStyle description = TextStyle(
    color: Colors.black,
    fontSize: 14,
  );

  static const TextStyle descriptionWithBoldFont = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.07
  );


  static const TextStyle descriptionWithBoldFontWithoutSpacing = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle titleWhiteColor = TextStyle(
      color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700);


  static const TextStyle descriptionWithBoldFontWithLargeFont = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.07
  );


}
// Weight:
// 400 - Normal
// 500 - Medium
// 600 - Semi Bold
// 700 - Bold
