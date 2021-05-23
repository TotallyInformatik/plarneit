import 'package:flutter/material.dart';

// UI CONSTANTS

const COLOR_WHITE = Color.fromRGBO(255, 255, 255, 1);
const COLOR_WHITESMOKE = Color.fromRGBO(245, 245, 245, 1);
const COLOR_INDIAN_RED = Color.fromRGBO(186, 71, 63, 1);
const FONT_COLOR = Color.fromRGBO(10, 10, 10, 1);

const VERY_URGENT_COLOR = Color.fromRGBO(138, 39, 32, 1);
const URGENT_COLOR = Color.fromRGBO(166, 57, 50, 1);
const MODERATE_COLOR = Color.fromRGBO(201, 84, 77, 1);
const NOT_URGENT_COLOR = Color.fromRGBO(227, 116, 109, 1);
const NOT_URGENT_AT_ALL_COLOR = Color.fromRGBO(250, 151, 145, 1);

const TextTheme TEXT_THEME_DEFAULT = TextTheme(
  headline1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 26),
  headline2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 22),
  headline3: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 20),
  headline4: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 16),
  headline5: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 14),
  headline6: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 12),
  bodyText1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 14, height: 1.5),
  bodyText2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 14, height: 1.5), // change this if needed
  subtitle1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 12),
  subtitle2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 12) // change if needed
);

const TextTheme TEXT_THEME_SMALL = TextTheme( // for smaller devices
    headline1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 22),
    headline2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 20),
    headline3: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 18),
    headline4: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 14),
    headline5: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 12),
    headline6: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 10),
    bodyText1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 12, height: 1.5),
    bodyText2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 12, height: 1.5), // change this if needed
    subtitle1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 10),
    subtitle2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 10) // change if needed
);

// App Layout constants:

// DayPage Layout:
const double listContainerInnerPadding = 20;

const double widgetSize = 150.0;
const double widgetPadding = 10.0;
const double widgetInnerPadding = 30.0;
const double widgetBorderRadius = 30.0;


// Other Constants:


const Map<int, String> MONTH_TO_STRING = {
  1: "January",
  2: "February",
  3: "March",
  4: "April",
  5: "May",
  6: "June",
  7: "Juli",
  8: "August",
  9: "September",
  10: "October",
  11: "November",
  12: "December"
};

// Json Constants:
const String JSON_FILE_NAME = "localstorage.json";