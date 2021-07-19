import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:plarneit/Data/SettingsData.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/Pages/HomePage.dart';
import 'package:plarneit/utils/conversion.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(PlarneitApp());
  });
}

class PlarneitApp extends StatelessWidget {

  static final COLOR_WHITE = Color.fromRGBO(255, 255, 255, 1);
  static final COLOR_WHITESMOKE = Color.fromRGBO(245, 245, 245, 1);
  static final FONT_COLOR = Color.fromRGBO(10, 10, 10, 1);
  static final WHITE_FONT_COLOR = Colors.white;
  static final DARK_GRAY = Color.fromRGBO(40, 40, 40, 1);


  static final TextTheme TEXT_THEME_DEFAULT = TextTheme(
      headline1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 26),
      headline2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 22),
      headline3: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 20),
      headline4: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 16),
      headline5: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 14),
      headline6: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 12),
      bodyText1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 14, height: 1.5),
      bodyText2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 16, height: 1.5), // change this if needed
      subtitle1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 12),
      subtitle2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 14) // change if needed
  );

  static final TextTheme TEXT_THEME_SMALL = TextTheme( // for smaller devices
      headline1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 22),
      headline2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 20),
      headline3: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 18),
      headline4: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 14),
      headline5: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 12),
      headline6: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 10),
      bodyText1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 12, height: 1.5),
      bodyText2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 14, height: 1.5), // change this if needed
      subtitle1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 10),
      subtitle2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 12) // change if needed
  );

  static final TextTheme TEXT_THEME_SMALLEST = TextTheme( // for even smaller devices
      headline1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 20),
      headline2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 18.5),
      headline3: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 15),
      headline4: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 13),
      headline5: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 11),
      headline6: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 10),
      bodyText1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 11, height: 1.5),
      bodyText2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 14, height: 1.5), // change this if needed
      subtitle1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 10),
      subtitle2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 12) // change if needed
  );

  static final TextTheme TEXT_THEME_DEFAULT_WHITE = TextTheme(
      headline1: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 26),
      headline2: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 22),
      headline3: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 20),
      headline4: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 16),
      headline5: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 14),
      headline6: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 12),
      bodyText1: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 14, height: 1.5),
      bodyText2: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 14, height: 1.5), // change this if needed
      subtitle1: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 12),
      subtitle2: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 12) // change if needed
  );

  static final TextTheme TEXT_THEME_SMALL_WHITE = TextTheme(
      headline1: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 22),
      headline2: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 20),
      headline3: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 18),
      headline4: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 14),
      headline5: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 12),
      headline6: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 10),
      bodyText1: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 12, height: 1.5),
      bodyText2: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 14, height: 1.5), // change this if needed
      subtitle1: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 10),
      subtitle2: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 12) // change if needed
  );

  static final TextTheme TEXT_THEME_SMALLEST_WHITE = TextTheme(
      headline1: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 20),
      headline2: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 18.5),
      headline3: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 15),
      headline4: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 13),
      headline5: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 11),
      headline6: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 10),
      bodyText1: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 11, height: 1.5),
      bodyText2: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 14, height: 1.5), // change this if needed
      subtitle1: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 10),
      subtitle2: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 12) // change if needed
  );

  static final String taskStorage = "tasks.json";
  static final String noteStorage = "notes.json";
  static final String longtermGoalsStorage = "longterm-goals.json";
  static final String settingsStorage = "settings.json";
  static final JsonHandlerCollection jsonHandlerCollection = new JsonHandlerCollection(
    JsonHandler(taskStorage),
    JsonHandler(noteStorage),
    JsonHandler(longtermGoalsStorage),
    JsonHandler(settingsStorage, initialMap: SettingsData.standardMap)
  );

  static final double contentResponseWidth1 = 500;
  static final double contentResponseWidth2 = 320; // dieses Attribut legt fest, ab wann die Schriftgröße geändert wird

  void deleteWidgets(JsonHandler handler, double autoDeletionPeriod) async {
    Map contents = await handler.readFile();
    List<String> toDelete = []; // list of keys to delete from taskhandler
    for (MapEntry dayEntry in contents.entries) {
      DateTime currentDate = dateX.fromString(dayEntry.key);
      DateTime earliestPermittedDate = DateTime.now().subtract(Duration(days: autoDeletionPeriod.toInt()));

      if (currentDate.isBefore(earliestPermittedDate)) {
        toDelete.add(dayEntry.key);
      }

    }
    contents.removeWhere((key, value) => toDelete.contains(key));
    handler.writeToJson(contents);
  }

  void deleteOutdatedShorttermWidgets() async {

    Map settings = await jsonHandlerCollection.settingsHandler.readFile();
    double autoDeletionPeriod = settings[SettingsData.autoDeletionPeriodTag];

    if (autoDeletionPeriod != SettingsData.autoDeletionPeriodMaximumValue) {
      deleteWidgets(jsonHandlerCollection.taskHandler, autoDeletionPeriod);
      deleteWidgets(jsonHandlerCollection.noteHandler, autoDeletionPeriod);
    }

  }

  void displayJsonContents() async {
    print(await jsonHandlerCollection.taskHandler.readFile());
    print(await jsonHandlerCollection.noteHandler.readFile());
    print(await jsonHandlerCollection.longtermGoalsHandler.readFile());
    print(await jsonHandlerCollection.settingsHandler.readFile());
  }

  TextTheme determinePrimaryTextTheme(double screenWidth) {
    if (screenWidth > contentResponseWidth1) {
      return TEXT_THEME_DEFAULT;
    } else if (screenWidth > contentResponseWidth2) {
      return TEXT_THEME_SMALL;
    } else {
      return TEXT_THEME_SMALLEST;
    }
  }

  TextTheme determineAccentTextTheme(double screenWidth) {
    if (screenWidth > contentResponseWidth1) {
      return TEXT_THEME_DEFAULT_WHITE;
    } else if (screenWidth > contentResponseWidth2) {
      return TEXT_THEME_SMALL_WHITE;
    } else {
      return TEXT_THEME_SMALLEST_WHITE;
    }
  }

  double determineIconSize(double screenWidth) {
    if (screenWidth > contentResponseWidth2) {
      return 30;
    } else {
      return 20;
    }
  }

  @override
  Widget build(BuildContext context) {
    deleteOutdatedShorttermWidgets();
    displayJsonContents();

    double mediaQueryWidth = window.physicalSize.width / window.devicePixelRatio;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'plarneit',
      theme: ThemeData(
        primaryColor: COLOR_WHITE,
        accentColor: DARK_GRAY,
        accentTextTheme: determineAccentTextTheme(mediaQueryWidth),
        primaryTextTheme: determinePrimaryTextTheme(mediaQueryWidth),
        fontFamily: "Montserrat",
        iconTheme: IconThemeData(
          size: determineIconSize(mediaQueryWidth),
          color: Colors.black
        )
      ),
      home: HomePage()
    );
  }
}