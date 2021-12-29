import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//LightTheme
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.green,
  textTheme: lightTextTheme,
);

TextStyle lightTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.white,
);
TextStyle headText1 = GoogleFonts.cairo(
  fontSize: 18,
  color: Colors.white,
);
TextStyle headText2 = GoogleFonts.cairo(
  fontSize: 18,
  color: Colors.white,
);
TextTheme lightTextTheme =
    TextTheme(bodyText1: lightTextStyle, headline1: headText1);

//DarkTheme
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
);

TextStyle darkTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.white,
);
TextTheme darkTextTheme =
    TextTheme(bodyText1: lightTextStyle, headline1: headText2);
