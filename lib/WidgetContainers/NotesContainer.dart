import 'package:flutter/material.dart';
import 'package:plarneit/Data/WidgetData.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/UserInput/Dialogs.dart';
import 'package:plarneit/UserMadeWidget/ID.dart';
import 'package:plarneit/UserMadeWidget/NoteWidget.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';
import 'package:plarneit/WidgetContainers/WidgetContainer.dart';
import 'package:plarneit/utils/conversion.dart';



class NoteContainer extends WidgetContainer {


  NoteContainer(Future<Map> startingWidgetsMap, DateTime date) : super(startingWidgetsMap, date, "notes");

  @override
  State<StatefulWidget> createState() => _NoteContainerState();

}

class _NoteContainerState extends WidgetContainerState<NotesData> {


  @override
  UserMadeWidgetBase<NotesData> createWidget(NotesData widgetInformation, WidgetId id) {
    return NoteWidget(
        widgetInformation,
        this.statusController,
        id,
        this.widgetDeletionFunction,
        JsonHandlerWidget.of(context).noteHandler,
        this.widget.identifier
    );
  }

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

          newWidgets.add(createWidget(
              NotesData(
                  widget.value[WidgetData.titleTag],
                  widget.value[WidgetData.descriptionTag],
                  colorX.fromString(widget.value[NotesData.colorTag])
              ),
              newId // increments id count
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
  Future<UserMadeWidgetBase<WidgetData>> addWidget() async {
    NotesData widgetInformation = await CustomDialogs.showNoteEditDialog(context);
    if (widgetInformation != null) {
      return createWidget(widgetInformation, NoteId(this.nextWidgetId));
    }
  }

}