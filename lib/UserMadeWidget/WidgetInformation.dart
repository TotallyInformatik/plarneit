import 'package:flutter/material.dart';

class WidgetInformation {

  static final titleTag = "title";
  static final descriptionTag = "description";
  static final starttimeTag = "starttime";
  static final endtimeTag = "endtime";

  final String title;
  final String description;

  WidgetInformation(this.title, this.description);

}

class TaskInformation extends WidgetInformation {

  static final starttimeTag = "starttime";
  static final endtimeTag = "endtime";

  final TimeOfDay starttime;
  final TimeOfDay endtime;

  TaskInformation(String title, String description, this.starttime, this.endtime) : super(title, description);

}

class NotesInformation extends WidgetInformation {

  static final colorTag = "color";

  final Color color;

  NotesInformation(String title, String description, this.color) : super(title, description);


}