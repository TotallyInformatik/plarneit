import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/Data/WidgetData.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/UserInput/Dialogs.dart';
import 'package:plarneit/UserMadeWidget/ID.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';
import 'package:plarneit/utils/conversion.dart';

class NoteWidget extends UserMadeWidgetBase<NotesData> {

  NoteWidget(WidgetData widgetInformation, WidgetContainerStatusController statusController, WidgetId id, Function widgetDeletionFunction, JsonHandler jsonHandler, DateTime identifier, {Key key})
      : super(widgetInformation, statusController, id, widgetDeletionFunction, jsonHandler, identifier.xToString(), key: key);

  @override
  State<StatefulWidget> createState() =>
      NoteWidgetState();

  @override
  Map<String, String> updateAddition(NotesData newWidgetInformation) {
    Map<String, String> result = {};
    result[NotesData.colorTag] = newWidgetInformation.color.xToString();

    return result;
  }

}

class NoteWidgetState extends UserMadeWidgetBaseState<NotesData> {

  Color _color;

  @override
  void updateAttributes(NotesData widgetInformation) {
    this.setState(() {
      this.title = widgetInformation.title;
      this.description = widgetInformation.description;
      this._color = widgetInformation.color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return this.returnStandardBuild(context, [],
        noteColor: this._color, invertFontColor: true
    );
  }

  @override
  void editingFunction() async {
    NotesData newWidgetInformation = await CustomDialogs.showNoteEditDialog(context, title: this.title, description: this.description, color: this._color);
    if (newWidgetInformation != null) {
      this.updateWidget(newWidgetInformation);
    }
  }

}