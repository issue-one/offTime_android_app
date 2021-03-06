import 'package:flutter/material.dart';

class MyTheme{
  
 static final darkAppTheme = ThemeData(
  primaryColor: Colors.black,
  accentColor: Colors.white,
  focusColor: Color.fromRGBO(255,189,0,1.0),
  backgroundColor: Colors.black,

  textTheme: TextTheme(
    headline1: TextStyle( fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontSize: 28, color: Colors.white ),
    headline2:TextStyle( fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 24, color: Colors.white,),
    headline3: TextStyle(fontFamily: 'Corben', fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white,),
    overline: TextStyle(fontFamily: 'Corben', fontWeight: FontWeight.w400, fontSize: 18, color: Colors.white54,),
    
    headline4: TextStyle(decoration: TextDecoration.underline ,fontFamily: 'Corben', fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white,),
    button: TextStyle(fontFamily: 'Corben', fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black,),),
);
static final lightAppTheme = ThemeData(
  primaryColor: Colors.white,
  accentColor: Colors.black,
  focusColor: Color.fromRGBO(255,189,0,1.0),
  backgroundColor: Colors.white,
  

  textTheme: TextTheme(
    overline: TextStyle(fontFamily: 'Corben', fontWeight: FontWeight.w400, fontSize: 18, color: Colors.black54,),
    
    headline1: TextStyle( fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontSize: 28, color: Colors.black ),
    headline2:TextStyle( fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 24, color: Colors.black,),
    headline3: TextStyle(fontFamily: 'Corben', fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black,),
    headline4: TextStyle(decoration: TextDecoration.underline ,fontFamily: 'Corben', fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black,),
    button: TextStyle(fontFamily: 'Corben', fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white,),),
);



}