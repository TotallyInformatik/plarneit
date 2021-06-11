import 'package:flutter/material.dart';
import 'package:plarneit/WidgetContainers/LongtermNotesContainer.dart';

abstract class WidgetInformation {

  static final String titleTag = "title";
  static final String descriptionTag = "description";

  final String title;
  final String description;

  WidgetInformation(this.title, this.description);

}

class TaskInformation extends WidgetInformation {

  static final String starttimeTag = "startTime";
  static final String endtimeTag = "endTime";

  final TimeOfDay starttime;
  final TimeOfDay endtime;

  TaskInformation(String title, String description, this.starttime, this.endtime) : super(title, description);

}

class NotesInformation extends WidgetInformation {

  static final String colorTag = "color";

  final Color color;

  NotesInformation(String title, String description, this.color) : super(title, description);


}

class LongtermNotesInformation extends NotesInformation {

  static final String termTag = "term";

  final Term term;

  LongtermNotesInformation(String title, String description, Color color, this.term) : super(title, description, color);

}