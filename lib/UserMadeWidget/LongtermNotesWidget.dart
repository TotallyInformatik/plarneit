import 'package:flutter/material.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/UserInput/Dialogs.dart';
import 'package:plarneit/UserMadeWidget/ID.dart';
import 'package:plarneit/UserMadeWidget/NoteWidget.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';
import 'file:///C:/Users/Ruine/OneDrive/Desktop/Rui/Programming/CodingProjects/Unfinished/plarneit/lib/Data/WidgetData.dart';
import 'package:plarneit/WidgetContainers/LongtermNotesContainer.dart';
import 'package:plarneit/utils/conversion.dart';

class LongtermNotesWidget extends UserMadeWidgetBase<LongtermNotesData> {

  LongtermNotesWidget(LongtermNotesData widgetInformation, WidgetContainerStatusController statusController, WidgetId id, Function widgetDeletionFunction, JsonHandler jsonHandler, DateTime identifier) :
        super(widgetInformation, statusController, id, widgetDeletionFunction, jsonHandler, identifier.xToString(yearOnly: true), "note");

  @override
  State<StatefulWidget> createState() =>
      _LongtermNotesWidgetState();

  @override
  Map updateAddition(LongtermNotesData newWidgetInformation) {
    Map<String, String> result = {};
    result[NotesData.colorTag] = newWidgetInformation.color.xToString();
    result[LongtermNotesData.termTag] = Conversion.enumToString(newWidgetInformation.term);

    return result;
  }

}

class _LongtermNotesWidgetState extends UserMadeWidgetBaseState<LongtermNotesData> {

  Color _color;

  @override
  Widget build(BuildContext context) {
    return this.returnStandardBuild(context, [], noteColor: this._color, invertFontColor: true);
  }

  @override
  void editingFunction() async {
    NotesData newWidgetInformation = await CustomDialogs.showNoteEditDialog(context, title: this.title, description: this.description, color: this._color);
    if (newWidgetInformation != null) {
      this.updateWidget(LongtermNotesData(
        newWidgetInformation.title,
        newWidgetInformation.description,
        newWidgetInformation.color,
        this.widget.widgetInformation.term
      ));
    }
  }


  @override
  void updateAttributes(LongtermNotesData widgetInformation) {
    this.setState(() {
      this.title = widgetInformation.title;
      this.description = widgetInformation.description;
      this._color = widgetInformation.color;
    });
  }
}
