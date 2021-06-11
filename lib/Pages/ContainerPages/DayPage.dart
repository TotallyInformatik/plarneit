import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/Pages/ContainerPages/ContainerPage.dart';
import 'package:plarneit/Pages/ContainerPages/Navigationbar.dart';
import 'package:plarneit/UserMadeWidget/NoteWidget.dart';
import 'package:plarneit/UserMadeWidget/TaskWidget.dart';
import 'package:plarneit/WidgetContainers/NotesContainer.dart';
import 'package:plarneit/WidgetContainers/TaskContainer.dart';
import 'package:plarneit/main.dart';
import 'package:plarneit/utils/conversion.dart';
import '../../WidgetContainers/WidgetContainer.dart';

class DayPage extends ContainerPage<DateTime> {

  static final double listContainerInnerPadding = 20;

  DayPage(DateTime date, JsonHandlerCollection jsonCollection, context) : super(date, jsonCollection, context);

  @override
  Widget build(BuildContext context) {

    return this.returnStandardBuild(
      context,
      [
        TaskContainer(this.configureObjectsMap(this.jsonCollection.taskHandler, this.identifier.xToString()), this.identifier),
        NoteContainer(this.configureObjectsMap(this.jsonCollection.noteHandler, this.identifier.xToString()), this.identifier)
      ],
      dateToText(this.identifier)
    );
  }

  void openPage(BuildContext context, DateTime date) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) => JsonHandlerWidget(
            jsonHandlers: PlarneitApp.jsonHandlerCollection,
            child: DayPage(date, this.jsonCollection, this.context))
        )
    );
  }

  @override
  void calendarFunction(BuildContext context) async {
    DateTime chosenDate = await showDatePicker(
      context: context,
      initialDate: this.identifier,
      firstDate: DateTime(this.identifier.subtract(Duration(days: 365)).year),
      lastDate: DateTime(this.identifier.add(Duration(days: 365)).year),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
            primaryColor: PlarneitApp.COLOR_WHITESMOKE,
            accentColor: PlarneitApp.DARK_GRAY,
            colorScheme: ColorScheme.light(primary: PlarneitApp.DARK_GRAY),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary
            )
          ),
          child: child
        );
      }
    );

    if (chosenDate != null && !chosenDate.dateEquals(this.identifier)) {
      openPage(context, chosenDate);
    }

  }

  @override
  void homeFunction(BuildContext context) {
    openPage(context, DateTime.now());
  }

  @override
  void nextFunction(BuildContext context) {
    openPage(context, this.identifier.add(Duration(days: 1)));
  }

  @override
  void prevFunction(BuildContext context) {
    openPage(context, this.identifier.subtract(Duration(days: 1)));
  }
}