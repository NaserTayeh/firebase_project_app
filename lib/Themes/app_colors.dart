// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppColors {
  static const kgreyColor = Color(0xff797b7a);
  static const kblackColor = Colors.black;
  static const kwhiteColor = Colors.white;
  static const kgradient1 = Color.fromARGB(255, 4, 68, 77);
  static const kgradient2 = Color.fromARGB(255, 52, 173, 188);
  static const kPrimaryColor = Color.fromARGB(255, 6, 57, 120);
  static const kPrimaryLightColor = Color(0xFFFFECDF);
  static const kPrimaryGradientColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
  );
  static const kSecondaryColor = Color(0xFF979797);
  static const kTextColor = Color(0xFF757575);

  // static const kAnimationDuration = Duration(milliseconds: 200);
  static ThemeData theme() {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Muli',
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: AppColors.kTextColor,
        ),
        bodyText2: TextStyle(color: AppColors.kTextColor),
      ),
      appBarTheme: AppBarTheme(
          textTheme: TextTheme(
              headline6: TextStyle(
                  fontSize: 18, color: Color.fromARGB(255, 145, 10, 10))),
          color: Colors.white,
          elevation: 0,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black)),
      primarySwatch: Colors.blue,
    );
  }
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: AppColors.kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}
