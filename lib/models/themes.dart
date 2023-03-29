import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "../config/config.dart";

class ThemeModel {
  final lightMode = ThemeData(
    primaryColor: Config.BLUE_DIANNE,
    //accentColor: Config().appColor,
    iconTheme: IconThemeData(color: Colors.grey[900]),
    fontFamily: "Poppins",
    scaffoldBackgroundColor: Colors.grey[100],
    brightness: Brightness.light,
    primaryColorDark: Colors.grey[800],
    primaryColorLight: Colors.white,
    secondaryHeaderColor: Colors.grey[600],
    shadowColor: Colors.grey[200],
    backgroundColor: Colors.grey[100],
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      color: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.grey[900],
      ),
      actionsIconTheme: IconThemeData(color: Colors.grey[900]),
      titleTextStyle: TextStyle(
        fontFamily: "Poppins",
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.6,
        wordSpacing: 1,
        color: Colors.grey[900],
      ),
    ),
    textTheme:  TextTheme(
        headlineSmall:TextStyle( color: Colors.black),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Config().appColor,
      unselectedItemColor: Colors.grey[500],
    ),
  );




  final darkMode = ThemeData(
      primaryColor: Config.BLUE_DIANNE,
      //accentColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.white),
      fontFamily: "Poppins",
      scaffoldBackgroundColor: const Color(0xff303030),
      brightness: Brightness.dark,
      primaryColorDark: Colors.grey[300],
      primaryColorLight: Colors.grey[800],
      secondaryHeaderColor: Colors.grey[400],
      shadowColor: Color(0xff282828),
      backgroundColor: const Color(0xff303030),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        color: Colors.grey[900],
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actionsIconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 18,
          letterSpacing: -0.6,
          wordSpacing: 1,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      textTheme: TextTheme(

      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
      ));
}
