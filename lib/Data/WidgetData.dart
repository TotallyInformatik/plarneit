import 'package:flutter/material.dart';
import 'package:plarneit/WidgetContainers/LongtermNotesContainer.dart';


///
/// WidgetData
/// WidgetData is the data used for the widgets that users create -> tasks, notes, longtermnotes
/// It is used to ensure that the data passed from dialogs and from json files are always in the correct format
///

abstract class WidgetData {

  static final String titleTag = "title";
  static final String descriptionTag = "description";

  final String title;
  final String description;

  WidgetData(this.title, this.description);

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

}

class NotesData extends WidgetData {

  static final String colorTag = "color";

  final Color color;

  NotesData(String title, String description, this.color) : super(title, description);


}

class LongtermNotesData extends NotesData {

  static final String termTag = "term";

  final Term term;

  LongtermNotesData(String title, String description, Color color, this.term) : super(title, description, color);

}