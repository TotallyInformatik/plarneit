import 'package:flutter/material.dart';
import 'package:plarneit/Data/WidgetData.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/UserInput/Dialogs.dart';
import 'package:plarneit/UserMadeWidget/ID.dart';
import 'package:plarneit/UserMadeWidget/LongtermNotesWidget.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';
import 'package:plarneit/WidgetContainers/WidgetContainer.dart';
import 'package:plarneit/utils/conversion.dart';

///
/// @author: Rui Zhang (TotallyInformatik)
///

enum Term {
  EARLY,
  MID,
  LATE
}

class LongtermNotesContainer extends WidgetContainer {

  final Term term;

  LongtermNotesContainer(Future<Map> startingWidgetsMap, DateTime year, this.term) : super(startingWidgetsMap, year, "${Conversion.enumToString(term)} ${year.xToString(yearOnly: true)}");

  @override
  State<StatefulWidget> createState() => _LongtermNotesContainer(this.term);

}

class _LongtermNotesContainer extends WidgetContainerState<LongtermNotesData> {

  final Term _term;
  _LongtermNotesContainer(this._term);

  @override
  UserMadeWidgetBase<LongtermNotesData> createWidget(LongtermNotesData widgetInformation, WidgetId id) {
    return LongtermNotesWidget(
        widgetInformation,
        this.statusController,
        id,
        this.widgetDeletionFunction,
        JsonHandlerWidget.of(context).longtermGoalsHandler,
        this.widget.identifier,
        key: UniqueKey()
    );
  }

  @override
  Widget build(BuildContext context) {
    return this.returnStandardBuild(context);
  }

  @override
  Future<UserMadeWidgetBase<LongtermNotesData>> addWidget() async {
    NotesData widgetInformation = await CustomDialogs.showNoteEditDialog(context);
    if (widgetInformation != null) {
      return createWidget(
          LongtermNotesData(
            widgetInformation.title,
            widgetInformation.description,
            widgetInformation.color,
            this._term
          ),
          NoteId.newId()
      );
    }
  }

  @override
  UserMadeWidgetBase<LongtermNotesData> initializeWidgetFromMap(MapEntry<dynamic, dynamic> widgetData) {

    if (Conversion.enumFromString(widgetData.value[LongtermNotesData.termTag], Term.values) == this._term) {
      NoteId id = WidgetId.fromString(widgetData.key);

      return createWidget(
          LongtermNotesData(
              widgetData.value[WidgetData.titleTag],
              widgetData.value[WidgetData.descriptionTag],
              colorX.fromString(widgetData.value[NotesData.colorTag]),
              Conversion.enumFromString(
                  widgetData.value[LongtermNotesData.termTag], Term.values)
          ),
          id
      );
    } else {
      return null;
    }

  }

}