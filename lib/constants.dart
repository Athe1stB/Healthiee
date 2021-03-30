import 'package:flutter/material.dart';

ThemeData defaultAppTheme = ThemeData(
  iconTheme: IconThemeData(color: Colors.white, size: 30),
  primaryColor: Colors.redAccent,
  backgroundColor: Colors.white,
  accentColor: Colors.red,
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.purple,
  hintColor: Colors.grey,
  cardTheme: CardTheme(
    color: Color(0xFFE9EEFA),
    elevation: 3.0,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.red,
  ),
  primaryColorLight: Colors.deepOrange,
  primaryColorDark: Colors.red[900],
  splashColor: Colors.red,
  buttonColor: Colors.red,
  
);

TextStyle styleBold = TextStyle(
  color: Color(0xFF2152D1),
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

TextStyle styleDarkGrayBold = TextStyle(
  color: Color(0xFF2152D1),
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

TextStyle styleBoldWhiteLarge = TextStyle(
  color: Colors.white,
  fontSize: 70,
  fontWeight: FontWeight.bold,
);

TextStyle styleBoldBlack = TextStyle(
  color: Colors.black,
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

TextStyle styleBoldBlackMedium = TextStyle(
  color: Colors.black,
  fontSize: 32,
  fontFamily: 'Kanit',
  fontWeight: FontWeight.bold,
);

TextStyle styleBoldGrayMedium = TextStyle(
  color: Colors.black54,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

TextStyle styleBoldWhite = TextStyle(
  color: Colors.white,
  fontSize: 40,
  letterSpacing: 2,
  fontFamily: 'Kanit',
  fontWeight: FontWeight.bold,
);

TextStyle styleBoldWhiteMedium = TextStyle(
  color: Colors.white,
  fontSize: 30,
  letterSpacing: 2,
  fontFamily: 'Kanit',
  fontWeight: FontWeight.bold,
);

TextStyle subHead = TextStyle(
  color: Colors.blue,
  fontSize: 20,
);
TextStyle normal = TextStyle(
  color: Colors.black,
  fontSize: 16,
);

TextStyle elementwhite = TextStyle(
  color: Colors.white,
  fontSize: 20,
);

TextStyle elementgray = TextStyle(
  color: Colors.grey,
  fontSize: 16,
);

TextStyle purpleNormalBold = TextStyle(
  color: Colors.purple,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

TextStyle blueNormalBold = TextStyle(
  color: Colors.blue[900],
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

TextStyle profileText = TextStyle(
  color: Colors.purple,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

TextStyle profileTextBlue = TextStyle(
  color: Colors.blue,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);



InputDecoration createacdec = InputDecoration(
  labelText: 'Name',
  labelStyle: normal,
  focusColor: Colors.red,
);

class Constants {}
