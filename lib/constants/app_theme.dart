import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// dark theme
var darkBackgroundColor = Color(0xff111B21);
Color darkAppBarColor = Color(0xff202C33);
Color darkPrimaryColor =  Color(0xff218c74);
Color darkSecondaryColor = Color(0xff111B21);
Color darkInputBgColor = Colors.grey.shade800;

/// light theme
Color lightBackgroundColor = Colors.white;
Color lightAppbarColor = Color(0xff218c74);
Color lightCardColor = Color(0xffF7F9F9);
Color lightPrimaryColor = Color(0xff218c74);

var lightTheme = ThemeData(
  //textTheme: lightTextTheme,
  // useMaterial3: true,
  primarySwatch: Colors.green,

    primaryColor: lightPrimaryColor,
    cardColor: lightCardColor,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    dialogBackgroundColor: lightCardColor,
    dividerColor: Colors.grey.shade200.withOpacity(.8),
    dividerTheme: DividerThemeData(
      thickness: .8,
      color: Colors.grey.shade200.withOpacity(.7),
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: darkPrimaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: lightPrimaryColor,
        )),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: lightPrimaryColor,
        )),
    iconTheme: IconThemeData(color: Colors.blueGrey.shade700),
    appBarTheme: AppBarTheme(
        backgroundColor: lightAppbarColor,
        elevation: 1,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        iconTheme: IconThemeData(color: Colors.white),),
    hintColor: darkPrimaryColor,


    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white54,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey)),
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: lightPrimaryColor)),
    ));

var darkTheme = ThemeData(
    primarySwatch: Colors.green,
    primaryColor: darkPrimaryColor,
    cardColor: darkSecondaryColor,
    bottomAppBarColor: darkAppBarColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackgroundColor,

    appBarTheme: AppBarTheme(
        elevation: .5,
        shadowColor: Colors.white,
        backgroundColor: darkAppBarColor,
        titleTextStyle: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600)),

    dialogBackgroundColor: darkSecondaryColor,

    //  TextStyle: darkTextStyle,


    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.blue.shade100),
    ),
    dividerTheme: DividerThemeData(color: Colors.white12),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkInputBgColor.withOpacity(.2),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color:darkPrimaryColor)),
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkPrimaryColor)),
    ), textSelectionTheme: TextSelectionThemeData(cursorColor: darkPrimaryColor,),hintColor: darkPrimaryColor);

var lightTextTheme = TextTheme(
  headline1: GoogleFonts.openSans(
      fontSize: 97,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: Colors.black),
  headline2: GoogleFonts.openSans(
      fontSize: 61,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: Colors.black87),
  headline3: GoogleFonts.openSans(fontSize: 48, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.openSans(
      fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.openSans(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.openSans(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.openSans(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Colors.black),
  bodyText2: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.black87),
  button: GoogleFonts.openSans(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.openSans(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.openSans(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

var darkTextTheme = TextTheme(
  headline1: GoogleFonts.openSans(
    fontSize: 97,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    color: Colors.white,
  ),
  headline2: GoogleFonts.openSans(
      fontSize: 61,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: Colors.white),
  headline3: GoogleFonts.openSans(
      fontSize: 48, fontWeight: FontWeight.w400, color: Colors.white),
  headline4: GoogleFonts.openSans(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.white),
  headline5: GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.openSans(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.openSans(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.openSans(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Colors.white),
  bodyText2: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.white),
  button: GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    color: Colors.white,
  ),
  caption: GoogleFonts.openSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  overline: GoogleFonts.openSans(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
