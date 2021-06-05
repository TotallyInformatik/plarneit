import 'package:flutter/material.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/UserMadeWidget/ID.dart';
import 'package:plarneit/UserMadeWidget/NoteWidget.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';

enum Term {
  EARLY,
  MID,
  LATE
}

class LongtermGoalsWidget extends NoteWidget {

  final Term term;

  LongtermGoalsWidget(WidgetInformation widgetInformation, WidgetContainerStatusController statusController, WidgetId id, Function widgetDeletionFunction, JsonHandler jsonHandler, DateTime identifier, this.term) : super(widgetInformation, statusController, id, widgetDeletionFunction, jsonHandler, identifier);

  @override
  State<StatefulWidget> createState() =>
      LongtermGoalsWidgetState();


}

class LongtermGoalsWidgetState extends NoteWidgetState {
  @override
  void editingFunction() {
    // TODO: implement editingFunction
  }
}
