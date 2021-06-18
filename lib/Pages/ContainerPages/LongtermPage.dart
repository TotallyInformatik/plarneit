import 'package:flutter/material.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/Pages/ContainerPages/ContainerPage.dart';
import 'package:plarneit/UserInput/Dialogs.dart';
import 'package:plarneit/WidgetContainers/LongtermNotesContainer.dart';
import 'package:plarneit/main.dart';
import 'package:plarneit/utils/conversion.dart';

///
/// LongtermPage
/// Page with three LongtermNotesContainers
/// Each Container is for one term
/// each Page reflects one year
///

class LongtermPage extends ContainerPage {

  LongtermPage(DateTime year, JsonHandlerCollection jsonCollection, BuildContext context) : super(year, jsonCollection, context);

  @override
  Widget build(BuildContext context) {

    Future<Map> allLongtermObjects = this.configureObjectsMap(this.jsonCollection.longtermGoalsHandler, this.identifier.xToString(yearOnly: true));

    return this.returnStandardBuild(
        context,
        [
          LongtermNotesContainer(allLongtermObjects, this.identifier, Term.EARLY),
          LongtermNotesContainer(allLongtermObjects, this.identifier, Term.MID),
          LongtermNotesContainer(allLongtermObjects, this.identifier, Term.LATE),
        ],
        this.identifier.xToString(yearOnly: true)
    );
  }

  void openPage(BuildContext context, DateTime date) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) => JsonHandlerWidget(
            jsonHandlers: PlarneitApp.jsonHandlerCollection,
            child: LongtermPage(date, this.jsonCollection, this.context))
        )
    );
  }


  @override
  void calendarFunction(BuildContext context) async {
    DateTime chosenYear = await CustomDialogs.showYearPicker(context);
    if (chosenYear != null) {
      openPage(context, chosenYear);
    }
  }

  @override
  void homeFunction(BuildContext context) {
    openPage(context, DateTime.now());
  }

  @override
  void nextFunction(BuildContext context) {
    openPage(context, DateTime(this.identifier.year + 1));
  }

  @override
  void prevFunction(BuildContext context) {
    openPage(context, DateTime(this.identifier.year - 1));
  }

}