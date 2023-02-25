import 'package:flutter/material.dart';

abstract class AppColor {
  static const transparent = Colors.transparent;

  //Light
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const primary = Color(0xFFF2E9FF);
  static const onPrimary = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF2D3748);
  static const splashBackgroundColor = Color(0xFF3949AB);
  static const textPrimaryLight = Color(0xFF9098B1);
  static const primaryRed = Color(0xFF333333);
  static const error = Color(0xFFFF5367);
  static const blue = Color(0xFF223263);
  static const border = Color(0xFFEBF0FF);
  static const enable = Color(0xFF9098B1);
  static const yellow = Color(0xFFFFCD00);
  static const dark = Color(0xFF05132E);
  static const lightBlue = Color(0xFF467FEC);
  static const lightGrey = Color(0xFFF3F5F9);
  static const darkGrey = Color(0xFFA4B3C6);
  static const tabGrey = Color(0xFFE7F0FF);
  static const primaryDark = Color(0xFF454F5A);
  static const lightPurple = Color(0xFFE0CCFC);
  static const lightGray = Color(0xFFE7F0FF);
  static const lightblack = Color(0xFF454F5A);
  static const lightCard = Color(0xFFEFE5FD);
  static const colorGreen = Color(0xFF00CF73);
  static const colorDarkGreen = Color(0xFF023020);
  static const colorGrey = Color(0xFF97A8BE);
  static const chatLive = Color(0xFF39CF75);
  static const chatBackGround = Color(0xFFF4F5F7);
  static const lighTred = Color(0xFFFFE4E4);
  static const pinSky = Color(0xFF00D1EE);
  static const lightYellow = Color(0xFFFFCB45);
  static const orange = Color(0xFFFFA500);
  static const sky = Color(0xFF007CEE);
  static const pink = Color(0xFFFF70AD);
  static const navyBlue = Color(0xFF006699);

  static const grey = MaterialColor(0xFFAEAEAE, <int, Color>{
    50: Color(0xFFF0F5F9),
    100: Color(0xFFE1E8F0),
    200: Color(0xFFCAD5E0),
    300: Color(0xFF91A4B7),
    400: Color(0xFF61758A),
    500: Color(0xFF445668),
    600: Color(0xFF304254),
    700: Color(0xFF1C2A3A),
    800: Color(0xFF0D1829),
    900: Color(0xFF030913),
  });

  static const secondary = MaterialColor(0xFF2557FC, <int, Color>{
    50: Color(0xFFF4F6FF),
    100: Color(0xFFEAEFFF),
    200: Color(0xFFD3DDFE),
    300: Color(0xFFA8BCFE),
    400: Color(0xFF7C9AFD),
    500: Color(0xFF5179FD),
    600: Color(0xFF2557FC),
    700: Color(0xFF1B42D8),
    800: Color(0xFF1230B5),
    900: Color(0xFF0B2192),
  });

  static const green = MaterialColor(0xFF26A548, <int, Color>{
    50: Color(0xFFF4FAF6),
    100: Color(0xFFEAF6ED),
    200: Color(0xFFD4EDDA),
    300: Color(0xFFA8DBB6),
    400: Color(0xFF7DC991),
    500: Color(0xFF51B76D),
    600: Color(0xFF26A548),
    700: Color(0xFF1B8D45),
    800: Color(0xFF137641),
    900: Color(0xFF0C5F3A),
  });

  static const red = MaterialColor(0xFFE1194B, <int, Color>{
    50: Color(0xFFFDF3F6),
    100: Color(0xFFFCE8ED),
    200: Color(0xFFF9D1DB),
    300: Color(0xFFF3A3B7),
    400: Color(0xFFED7593),
    500: Color(0xFFE7476F),
    600: Color(0xFFE1194B),
    700: Color(0xFFC1124F),
    800: Color(0xFFA20C4E),
    900: Color(0xFF82074A),
  });

  //Dark
  static const beige = Color(0xFF6200EE);
  static const onSecondry = Color(0xFF292D32);
  static const textPrimaryDark = Color(0xFF6200EE);
  static const textPrimaryLightDark = Color(0xFFFFFFFF);
  static const trailingColor = Color(0xFFEDF4FF);
  static const darkBlue = Color(0xFF0000FF);
}
/*

class AppLightColors extends AppColor {
  @override
  final Color primary = const Color(0xFFF2E9FF);
}

abstract class AppDarkColors extends A
  @override
  final Color primary = Color(0xFF6200EE);
}
*/
