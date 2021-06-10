import 'package:flutter/material.dart';

final Color lightPrimary = Colors.pink[200];
final Color darkPrimary = Colors.black;
final Color lightAccent = Colors.pink[200];
final Color darkAccent = Colors.blueAccent;
//  static Color lightBG = Color(0xfffcfcff);
final Color lightBG = Colors.grey.shade50;
final Color darkBG = Colors.black;
final Color badgeColor = Colors.red;

final Color textColor = Color(0xff7a86b6);
final Color bgColor = Color(0xffb4e0df);

final ThemeData appThemeData = ThemeData(
  backgroundColor: lightBG,
  primaryColor: Color(0xffb4e0df),
  scaffoldBackgroundColor: Colors.white,
  accentColor: textColor,
  cursorColor: textColor,
  splashColor: Colors.grey.shade50,
  highlightColor: Colors.grey.shade50,
  fontFamily: 'Varela',
  appBarTheme: AppBarTheme(
    elevation: 0.5,
    textTheme: TextTheme(
      title: TextStyle(
        color: Color(0xff7a86b6),
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
        color: textColor, fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
);
