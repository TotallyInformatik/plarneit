import 'package:flutter/material.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/UserInput/Dialogs.dart';
import 'package:plarneit/UserMadeWidget/ID.dart';
import 'package:plarneit/UserMadeWidget/LongtermNotesWidget.dart';
import 'package:plarneit/UserMadeWidget/NoteWidget.dart';
import 'package:plarneit/UserMadeWidget/TaskWidget.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';
import 'package:plarneit/WidgetContainers/WidgetContainer.dart';
import 'package:plarneit/utils/conversion.dart';

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

class _LongtermNotesContainer extends WidgetContainerState<LongtermNotesInformation> {

  final Term _term;
  _LongtermNotesContainer(this._term);

  @override
  UserMadeWidgetBase<LongtermNotesInformation> createWidget(LongtermNotesInformation widgetInformation, WidgetId id) {
    return LongtermNotesWidget(
        widgetInformation,
        this.statusController,
        id,
        this.widgetDeletionFunction,
        JsonHandlerWidget.of(context).longtermGoalsHandler,
        this.widget.identifier
    );
  }

  @override
  void initializeWidgets(BuildContext context) async {
    if (await this.widget.startingWidgetsMap != null) {
      for (MapEntry widget in (await this.widget.startingWidgetsMap).entries) {

        WidgetId newId = WidgetId.fromString(widget.key);

        if (Conversion.enumFromString(widget.value[LongtermNotesInformation.termTag], Term.values) == this._term) {

          this.setState(() {
            List<UserMadeWidgetBase> newWidgets = this.widgets;

            newWidgets.add(createWidget(
                LongtermNotesInformation(
                    widget.value[WidgetInformation.titleTag],
                    widget.value[WidgetInformation.descriptionTag],
                    colorX.fromString(widget.value[NotesInformation.colorTag]),
                    Conversion.enumFromString(widget.value[LongtermNotesInformation.termTag], Term.values)
                ),
                newId
            ));

            this.widgets = newWidgets;

          });

        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return this.returnStandardBuild(context);
  }

  /// da alle drei LongtermNotesContainers dieselbe ID nutzen, muss immer die nächste Identifikationsnummer gefunden werden, wenn ein Widget hinzugefügt wird
  Future<int> getNextId() async {

    int currentHighestId = 1;
    Map<String, dynamic> currentJsonContent = await JsonHandlerWidget.of(context).longtermGoalsHandler.readFile();
    Map<String, dynamic> longtermWidgets = currentJsonContent[this.widget.identifier.xToString(yearOnly: true)];

    if (longtermWidgets != null) {
      longtermWidgets.keys.forEach((String key) {
        int id = WidgetId.fromString(key).number;
        if (id > currentHighestId) {
          currentHighestId = id;
        }
      });
      return currentHighestId + 1;
    } else {
      return 1;
    }

  }

  @override
  Future<UserMadeWidgetBase<LongtermNotesInformation>> addWidget() async {
    NotesInformation widgetInformation = await CustomDialogs.showNoteEditDialog(context);
    if (widgetInformation != null) {
      return createWidget(
          LongtermNotesInformation(
            widgetInformation.title,
            widgetInformation.description,
            widgetInformation.color,
            this._term
          ),
          NoteId(await getNextId())
      );
    }
  }

}