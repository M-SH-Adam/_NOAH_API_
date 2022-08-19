import 'package:flutter/material.dart';

class CustomColors {
  //TODO Define your colors here
  const CustomColors();

  static const Color primaryColorLight = Color(0xFF073a53);
  static const Color primaryColor = Color(0xFF0E4DFB);
  static const Color secondaryColorLight = Color(0xffff8e33);

  static final Color mainColor = Color.fromARGB(255, 255, 182, 54);
  static final Color secondColor = Color.fromARGB(255, 255, 182, 54);
  static Color textColor = Color.fromARGB(255, 0, 0, 0);
  static const Color gray = Color(0xFF808080);
  static const Color lightGray = Color(0xFFF5F5F5);
  static const Color grayText = Color(0xFF4D4D4D);
  static const Color green = Color(0xFF1DC264);
  static const Color lightGreen = Color(0xFFEAEFFF);
  static const Color yellow = Color(0xFFFFB948);
  static const Color gold = Color(0xFFFCC060);
  static const Color blueWhite = Color(0xFFE5F5FE);
  static const Color orange =  Color(0xFFF8883D);
  static const Color liteYellow = Color(0xFFFADBAE);


  static const Color borderLightGrayColor = Colors.black12;


  static const red = Color(0xFFBC0D00);
  static const blueLite = Color.fromRGBO(229,242,254,1);
  static const scaffoldBackGroundColor = Color.fromRGBO(236, 236, 236, 1.0);
  static const blackLite = Color.fromRGBO(0, 0, 0, 0.06);
  static const Color blue = Color(0xff1441a6);
  static const Color primaryBlue = Color(0xFF0082FE);
  static const Color lightBlue = Color(0xff2a8fe4);
  static const Color blueLogo = Color(0xff04599c);

  //you can used also color without define ColorHex
  //may add 0xFF + hexa code of color like
  static const Color PRIMARY_COLOR = Color(0xFFECB01A);
  static const Color RED = Color(0xFFF74A36);

  static const Map<int, Color> gradientGreen = <int, Color>{
    50: Color(0xFFf2f8ef),
    100: Color(0xFFdfedd8),
    200: Color(0xFFc9e2be),
    300: Color(0xFFb3d6a4),
    400: Color(0xFFa3cd91),
    500: Color(0xFF93c47d),
    600: Color(0xFF8bbe75),
    700: Color(0xFF80b66a),
    800: Color(0xFF76af60),
    900: Color(0xFF64a24d)
  };

  static const Map<String, Color> gradientBlue = <String, Color>{
    "100": Color(0xFF00A3FE),
    "200": Color(0xFF0092FE),
    "300": Color(0xFF0082FE),
  };

  static const List<Color> gradientBlueColors = [
    Color(0xFF00A3FE),
    Color(0xFF0092FE),
    Color(0xFF0082FE),
  ];

  static final List<Color> gradientGrayColors = [
    Colors.black12,
    Colors.black12,
    Colors.black26,
  ];


}

class ColorHex extends Color {
  ColorHex(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
