import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/UserInput/Dialogs.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';
import 'package:plarneit/utils/conversion.dart';
import 'ID.dart';

class NoteWidget extends UserMadeWidgetBase<NotesInformation> {

  NoteWidget(WidgetInformation widgetInformation, WidgetContainerStatusController statusController, WidgetId id, Function widgetDeletionFunction, JsonHandler jsonHandler, DateTime identifier, {Key key})
      : super(widgetInformation, statusController, id, widgetDeletionFunction, jsonHandler, identifier.xToString(), "note", key: key);

  @override
  State<StatefulWidget> createState() =>
      NoteWidgetState();

  @override
  Map<String, String> updateAddition(NotesInformation newWidgetInformation) {
    Map<String, String> result = {};
    result[NotesInformation.colorTag] = newWidgetInformation.color.xToString();

    return result;
  }

}

class NoteWidgetState extends UserMadeWidgetBaseState<NotesInformation> {

  Color _color;

  @override
  void updateAttributes(NotesInformation widgetInformation) {
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
    NotesInformation newWidgetInformation = await CustomDialogs.showNoteEditDialog(context, title: this.title, description: this.description, color: this._color);
    if (newWidgetInformation != null) {
      this.updateWidget(newWidgetInformation);
    }
  }

}