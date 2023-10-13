import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class AppTheme {

  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: otripMaterial,
    appBarTheme: AppBarTheme(
      color: otripOrange,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
        titleLarge: TextStyle(
            fontWeight: FontWeight.bold
        ),
        titleMedium: TextStyle(


        ),
        titleSmall: TextStyle(

        )
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0)
      ),
      color: otripMaterial[50],
      elevation: 12.0,
    ),
    buttonTheme: ButtonThemeData(
        padding: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        )
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              EdgeInsets.all(12)
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            ),
          ),
          iconColor: MaterialStateProperty.all(
              Colors.blueGrey
          ),
        )
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    fontFamily: GoogleFonts.roboto().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.orange[800],
      unselectedItemColor: Colors.orange[100],
      // selectedItemColor: Colors.orange[800].withOpacity(0.7),
      // unselectedItemColor: Colors.orange[800].withOpacity(0.32),
      showUnselectedLabels: true,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      color: Colors.grey[900],
      iconTheme: IconThemeData(
        color: Colors.orange[800],
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.black26,
      onPrimary: Colors.black26,
      secondary: Colors.orange,
    ),
    cardTheme: CardTheme(
      color: Colors.grey[800],
    ),
    iconTheme: IconThemeData(
      color: Colors.grey[400],
    ),
    fontFamily: GoogleFonts.roboto().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[800],
      selectedItemColor: Colors.orange[800],
      unselectedItemColor: Colors.grey[400],
      showUnselectedLabels: true,
    ),
  );

  static const MaterialColor otripMaterial = MaterialColor(_otripMaterialPrimaryValue, <int, Color>{
    50: Color(0xFFFEE7E0),
    100: Color(0xFFFDC3B3),
    200: Color(0xFFFC9B80),
    300: Color(0xFFFA724D),
    400: Color(0xFFF95426),
    500: Color(_otripMaterialPrimaryValue),
    600: Color(0xFFF73000),
    700: Color(0xFFF62900),
    800: Color(0xFFF52200),
    900: Color(0xFFF31600),
  });
  static const int _otripMaterialPrimaryValue = 0xFFF83600;

  static const MaterialColor otripMaterialAccent = MaterialColor(_otripMaterialAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_otripMaterialAccentValue),
    400: Color(0xFFFFB7B3),
    700: Color(0xFFFF9E9A),
  });

  static const int _otripMaterialAccentValue = 0xFFFFE7E6;
}