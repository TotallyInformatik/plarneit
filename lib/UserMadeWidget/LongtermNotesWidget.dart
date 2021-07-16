import 'package:flutter/material.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/Data/WidgetData.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/UserInput/Dialogs.dart';
import 'package:plarneit/UserMadeWidget/ID.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';
import 'package:plarneit/utils/conversion.dart';

///
/// LongtermNotesWidget
/// A widget that basically has the same structure as a note-widget
/// however, the json file of longterm notes widgets also have to keep track of
/// the term the widget belongs to.
/// This way, the "updateAddition" function has to be altered by ONE line
///
/// Because the UserMadeWidgetBase class uses a generic to know which type of Data
/// this widget uses, this class cannot simply inherit from NotesWidget, leading
/// to a lot of "wet" code.
/// In Germany we say "doppelt gemoppelt :((((((((("
///

class LongtermNotesWidget extends UserMadeWidgetBase<LongtermNotesData> {

  LongtermNotesWidget(LongtermNotesData widgetInformation, WidgetContainerStatusController statusController, WidgetId id, Function widgetDeletionFunction, JsonHandler jsonHandler, DateTime identifier) :
        super(widgetInformation, statusController, id, widgetDeletionFunction, jsonHandler, identifier.xToString(yearOnly: true));

  @override
  State<StatefulWidget> createState() =>
      _LongtermNotesWidgetState();

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
