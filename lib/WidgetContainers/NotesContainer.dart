import 'package:flutter/material.dart';
import 'package:plarneit/Data/WidgetData.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/UserInput/Dialogs.dart';
import 'package:plarneit/UserMadeWidget/ID.dart';
import 'package:plarneit/UserMadeWidget/NoteWidget.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';
import 'package:plarneit/WidgetContainers/WidgetContainer.dart';
import 'package:plarneit/utils/conversion.dart';

///
/// @author: Rui Zhang (TotallyInformatik)
///

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
        this.widget.identifier,
        key: UniqueKey()
    );
  }

  @override
  Widget build(BuildContext context) {
    return this.returnStandardBuild(context);
  }

  @override
  Future<UserMadeWidgetBase<WidgetData>> addWidget() async {
    NotesData widgetInformation = await CustomDialogs.showNoteEditDialog(context);
    if (widgetInformation != null) {
      return createWidget(widgetInformation, NoteId.newId());
    }
  }

  @override
  UserMadeWidgetBase<NotesData> initializeWidgetFromMap(MapEntry<dynamic, dynamic> widgetData) {

    NoteId id = WidgetId.fromString(widgetData.key);

    return createWidget(
        NotesData(
            widgetData.value[WidgetData.titleTag],
            widgetData.value[WidgetData.descriptionTag],
            colorX.fromString(widgetData.value[NotesData.colorTag])
        ),
        id
    );
  }

}