import 'package:flutter/material.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/UserInput/Dialogs.dart';
import 'package:plarneit/UserMadeWidget/ID.dart';
import 'package:plarneit/UserMadeWidget/NoteWidget.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';
import 'package:plarneit/WidgetContainers/LongtermNotesContainer.dart';
import 'package:plarneit/utils/conversion.dart';

class LongtermNotesWidget extends UserMadeWidgetBase<LongtermNotesInformation> {

  LongtermNotesWidget(LongtermNotesInformation widgetInformation, WidgetContainerStatusController statusController, WidgetId id, Function widgetDeletionFunction, JsonHandler jsonHandler, DateTime identifier) :
        super(widgetInformation, statusController, id, widgetDeletionFunction, jsonHandler, identifier.xToString(yearOnly: true), "note");

  @override
  State<StatefulWidget> createState() =>
      _LongtermNotesWidgetState();

  @override
  Map updateAddition(LongtermNotesInformation newWidgetInformation) {
    Map<String, String> result = {};
    result[NotesInformation.colorTag] = newWidgetInformation.color.xToString();
    result[LongtermNotesInformation.termTag] = Conversion.enumToString(newWidgetInformation.term);

    return result;
  }

}

class _LongtermNotesWidgetState extends UserMadeWidgetBaseState<LongtermNotesInformation> {

  Color _color;

  @override
  Widget build(BuildContext context) {
    return this.returnStandardBuild(context, [], noteColor: this._color, invertFontColor: true);
  }

  @override
  void editingFunction() async {
    NotesInformation newWidgetInformation = await CustomDialogs.showNoteEditDialog(context, title: this.title, description: this.description, color: this._color);
    if (newWidgetInformation != null) {
      this.updateWidget(LongtermNotesInformation(
        newWidgetInformation.title,
        newWidgetInformation.description,
        newWidgetInformation.color,
        this.widget.widgetInformation.term
      ));
    }
  }


  @override
  void updateAttributes(LongtermNotesInformation widgetInformation) {
    this.setState(() {
      this.title = widgetInformation.title;
      this.description = widgetInformation.description;
      this._color = widgetInformation.color;
    });
  }
}
