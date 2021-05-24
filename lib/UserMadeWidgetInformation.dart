import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/utils/conversion.dart';
import 'package:plarneit/utils/spacing.dart';
import 'Dialogs.dart';
import 'utils/constants.dart';

import 'UrgencyTypes.dart';


// this class stores all information for userMadeWidgets and updates it accordingly in the json file


class UserMadeWidgetInformation {

  UrgencyTypes _urgency;
  String _title;
  String _description;
  TimeOfDay _starttime;
  TimeOfDay _endtime;

  final int _id;
  final DateTime _date;

  UrgencyTypes get urgency { return this._urgency; }
  String get title { return this._title; }
  String get description { return this._description; }
  int get id { return this._id; }
  DateTime get date { return this._date; }
  TimeOfDay get starttime { return this._starttime; }
  TimeOfDay get endtime { return this._endtime; }

  set urgency(UrgencyTypes value) {
    this._urgency = value;
    this._updateInformation("urgency", enumToString(value));
  }
  set title(String value) {
    this._title = value;
    this._updateInformation("title", value);
  }
  set description(String value) {
    this._description  = value;
    this._updateInformation("description", value);
  }
  set starttime(TimeOfDay value) {
    this._starttime = value;
    this._updateInformation("starttime", timeToString(value));
  }
  set endtime(TimeOfDay value) {
    this._endtime = value;
    this._updateInformation("endtime", timeToString(value));
  }


  UserMadeWidgetInformation(UrgencyTypes urgency, String title, String description, TimeOfDay starttime, TimeOfDay endtime, this._id, this._date) {
    this._urgency = urgency;
    this._title = title;
    this._description = description;
    this._starttime = starttime;
    this._endtime = endtime;

    // TODO: write to json
  }

  _updateInformation(String jsonKey, String jsonValue) {
    // TODO: write to json
  }

}