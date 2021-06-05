import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/UserMadeWidget/NoteWidget.dart';
import 'package:plarneit/UserMadeWidget/TaskWidget.dart';
import 'package:plarneit/WidgetContainers/TaskContainer.dart';
import 'package:plarneit/utils/conversion.dart';
import 'package:plarneit/utils/spacing.dart';
import 'WidgetContainers/WidgetContainer.dart';
import 'utils/constants.dart';

class DayPage extends StatelessWidget {
  DayPage(this.date);

  final DateTime date;

  Future<List> configureNotes(BuildContext context) async {
    JsonHandler noteHandler = JsonHandlerWidget.of(context).noteHandler;
    Map<String, dynamic> jsonContents = await noteHandler.readFile();
    Map<String, dynamic> noteObjectsMap = jsonContents[this.date.xToString()];
    if (noteObjectsMap != null) {
      return noteObjectsMap.values;
    } else {
      return null;
    }
  }

  Future<List> configureTasks(BuildContext context) async {
    JsonHandler taskHandler = JsonHandlerWidget.of(context).taskHandler;
    Map<String, dynamic> jsonContents = await taskHandler.readFile();
    Map<String, dynamic> taskObjectsMap = jsonContents[this.date.xToString()];

    if (taskObjectsMap != null) {
      List result = [];
      result.addAll(taskObjectsMap.values);
      return result;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {

    Future<List> notes = configureNotes(context);
    Future<List> tasks = configureTasks(context);

    return Scaffold(
        body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: TASK_COLOR,
                pinned: true,
                expandedHeight: 150.0,
                collapsedHeight: 80,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  titlePadding: EdgeInsets.only(left: listContainerInnerPadding, bottom: 30),
                  title: Text(
                      dateToText(date),
                      style: Theme.of(context).accentTextTheme.headline1,
                      textAlign: TextAlign.left
                  ),
                  background: Image(image: AssetImage("assets/images/forest1.jpg"), fit: BoxFit.cover),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    TaskContainer(tasks, this.date),
                    TaskContainer(notes, this.date)
                  ],
                ),
              )
            ]
        )
    );

  }

}