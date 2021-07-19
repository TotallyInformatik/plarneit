import 'package:flutter/material.dart';
import 'package:plarneit/Data/DataClass.dart';
import 'package:plarneit/utils/conversion.dart';

///
/// SettingsData:
/// contains all Data regarding settings of app
/// creates instances of SettingsData to change in SettingsPage
/// toMap() and fromJsonData() are used for writing to the settings.json file.
///

class SettingsData extends DataClass {

  static final String autoDeletionPeriodTag = "autoDeletionPeriodTag";
  static final String deletionPopupTag = "deletionPopup";
  static final double autoDeletionPeriodMaximumValue = 7; /// this value determines when to not delete automatically at all
  static final String allNoteColorsTag = "allNoteColors";

  static final Map standardMap = {
    SettingsData.autoDeletionPeriodTag: 3.0,
    SettingsData.deletionPopupTag: true,
    SettingsData.allNoteColorsTag: [
      Color.fromRGBO(255, 242, 171, 1).xToString(),
      Color.fromRGBO(203, 241, 196, 1).xToString(),
      Color.fromRGBO(255, 204, 229, 1).xToString(),
      Color.fromRGBO(205, 233, 255, 1).xToString(),
    ]
  };

  double autoDeletionPeriod;
  bool deletionPopup;
  List<Color> noteColors;

  SettingsData(double autoDeletionPeriod, bool deletionPopup, List<Color> noteColors) {
    this.autoDeletionPeriod = autoDeletionPeriod;
    this.deletionPopup = deletionPopup;
    this.noteColors = noteColors;
  }

  @override
  Map toMap() {

    List<String> noteColorsInStrings = [];
    this.noteColors.forEach((Color color) {
      noteColorsInStrings.add(color.xToString());
    });

    return {
      autoDeletionPeriodTag: this.autoDeletionPeriod,
      deletionPopupTag: this.deletionPopup,
      allNoteColorsTag: noteColorsInStrings
    };
  }

  static SettingsData fromJsonData(Map information) {
    double autoDeletionPeriod = information[autoDeletionPeriodTag];
    bool deletionPopup = information[deletionPopupTag];
    List noteColorsInStrings = information[allNoteColorsTag];
    List<Color> noteColors = [];


    noteColorsInStrings.forEach((hexString) {
      noteColors.add(colorX.fromString(hexString));
    });

    return SettingsData(autoDeletionPeriod, deletionPopup, noteColors);

  }

}