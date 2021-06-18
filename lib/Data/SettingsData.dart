import 'package:flutter/material.dart';
import 'package:plarneit/Data/DataClass.dart';

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

  double autoDeletionPeriod;
  bool deletionPopup;

  SettingsData(double autoDeletionPeriod, bool deletionPopup) {
    this.autoDeletionPeriod = autoDeletionPeriod;
    this.deletionPopup = deletionPopup;
  }

  @override
  Map toMap() {
    return {
      autoDeletionPeriodTag: this.autoDeletionPeriod,
      deletionPopupTag: this.deletionPopup
    };
  }

  static SettingsData fromJsonData(Map information) {
    double autoDeletionPeriod = information[autoDeletionPeriodTag];
    bool deletionPopup = information[deletionPopupTag];

    return SettingsData(autoDeletionPeriod, deletionPopup);

  }

}