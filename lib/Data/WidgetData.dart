import 'package:flutter/material.dart';
import 'package:plarneit/Data/DataClass.dart';
import 'package:plarneit/WidgetContainers/LongtermNotesContainer.dart';
import 'package:plarneit/utils/conversion.dart';


///
/// WidgetData
/// WidgetData is the data used for the widgets that users create -> tasks, notes, longtermnotes
/// It is used to ensure that the data passed from dialogs and from json files are always in the correct format
///

abstract class WidgetData extends DataClass {

  static final String titleTag = "title";
  static final String descriptionTag = "description";

  final String title;
  final String description;

  WidgetData(this.title, this.description);

  Map toMap() {
    return {
      titleTag: this.title,
      descriptionTag: this.description
    };
  }

}

///
/// All Subclasses of WidgetData contain additional Data that those widgets need
///

class TaskData extends WidgetData {

  static final String starttimeTag = "startTime";
  static final String endtimeTag = "endTime";

  final TimeOfDay starttime;
  final TimeOfDay endtime;

  TaskData(String title, String description, this.starttime, this.endtime) : super(title, description);

  @override
  Map toMap() {
    Map map = {
      starttimeTag: this.starttime.xToString()   ,
      endtimeTag: this.endtime.xToString(),
    };
    map.addAll(super.toMap());
    return map;
  }

}

class NotesData extends WidgetData {

  static final String colorTag = "color";

  final Color color;

  NotesData(String title, String description, this.color) : super(title, description);

  @override
  Map toMap() {
    Map map = {
      colorTag: this.color.xToString()
    };
    map.addAll(super.toMap());
    return map;
  }


}

class LongtermNotesData extends NotesData {

  static final String termTag = "term";

  final Term term;

  LongtermNotesData(String title, String description, Color color, this.term) : super(title, description, color);

  @override
  Map toMap() {
    Map map = {
      termTag: Conversion.enumToString(this.term)
    };
    map.addAll(super.toMap());
    return map;
  }

}