import 'package:flutter/material.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/UserInput/Dialogs.dart';
import 'package:plarneit/UserMadeWidget/ID.dart';
import 'package:plarneit/UserMadeWidget/NoteWidget.dart';
import 'package:plarneit/UserMadeWidget/TaskWidget.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';
import 'package:plarneit/WidgetContainers/WidgetContainer.dart';
import 'package:plarneit/utils/conversion.dart';

class NoteContainer extends WidgetContainer {


  NoteContainer(Future<Map> startingWidgetsMap, DateTime date) : super(startingWidgetsMap, date, "notes");

  @override
  State<StatefulWidget> createState() => _NoteContainerState();

}

class _NoteContainerState extends WidgetContainerState {

  @override
  void initializeWidgets(BuildContext context) async {
    int highestIdInt = 0;
    if (await this.widget.startingWidgetsMap != null) {
      for (MapEntry widget in (await this.widget.startingWidgetsMap).entries) {

        WidgetId newId = WidgetId.fromString(widget.key);
        if (newId.number > highestIdInt) {
          highestIdInt = newId.number;
        }

        this.setState(() {
          List<UserMadeWidgetBase> newWidgets = this.widgets;

          newWidgets.add(NoteWidget(
              NotesInformation(
                  widget.value[WidgetInformation.titleTag],
                  widget.value[WidgetInformation.descriptionTag],
                  colorX.fromString(widget.value[NotesInformation.colorTag])
              ),
              this.statusController,
              newId, // increments id count
              this.widgetDeletionFunction,
              JsonHandlerWidget.of(context).noteHandler,
              this.widget.date
          ));

          this.widgets = newWidgets;

        });
      }
    }
    this.nextWidgetId = highestIdInt + 1;
  }

  @override
  Widget build(BuildContext context) {
    return this.returnStandardBuild(context);
  }

  @override
  Future<UserMadeWidgetBase<WidgetInformation>> addWidget() async {
    NotesInformation widgetInformation = await CustomDialogs.showNoteEditDialog(context);
    if (widgetInformation != null) {
      return NoteWidget(widgetInformation, this.statusController, NoteId(this.nextWidgetId), this.widgetDeletionFunction, JsonHandlerWidget.of(context).noteHandler, this.widget.date);
    }
  }

}