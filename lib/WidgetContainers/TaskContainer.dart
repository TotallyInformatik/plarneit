import 'package:flutter/material.dart';
import 'package:plarneit/Data/WidgetData.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/UserInput/Dialogs.dart';
import 'package:plarneit/UserMadeWidget/ID.dart';
import 'package:plarneit/UserMadeWidget/TaskWidget.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';
import 'package:plarneit/WidgetContainers/WidgetContainer.dart';
import 'package:plarneit/utils/conversion.dart';

class TaskContainer extends WidgetContainer {


  TaskContainer(Future<Map> startingWidgetsMap, DateTime date) : super(startingWidgetsMap, date, "tasks");

  @override
  State<StatefulWidget> createState() => _TaskContainerState();

}

class _TaskContainerState extends WidgetContainerState<TaskData> {

  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    super.setState(fn);

    // sorts everytime the state updates so that tasks will always stay sorted
    this.widgets.sort((taskA, taskB) {
      int starttimeComparisonResult = taskA.widgetInformation.starttime.compareTo(taskB.widgetInformation.starttime);
      if (starttimeComparisonResult == 0) {
        int endtimeComparisonResult = taskA.widgetInformation.endtime.compareTo(taskB.widgetInformation.endtime);
        return endtimeComparisonResult;
      } else {
        return starttimeComparisonResult;
      }
    });

  }

  @override
  UserMadeWidgetBase<TaskData> createWidget(TaskData widgetInformation, WidgetId id) {
    return TaskWidget(
        widgetInformation,
        this.statusController,
        id,
        this.widgetDeletionFunction,
        JsonHandlerWidget.of(context).taskHandler,
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
    TaskData widgetInformation = await CustomDialogs.showTaskEditDialog(context);
    if (widgetInformation != null) {
      return createWidget(widgetInformation, TaskId.newId());
    }
  }

  @override
  UserMadeWidgetBase<TaskData> initializeWidgetFromMap(MapEntry<dynamic, dynamic> widgetData) {

    TaskId id = WidgetId.fromString(widgetData.key);

    return createWidget(
        TaskData(
            widgetData.value[WidgetData.titleTag],
            widgetData.value[WidgetData.descriptionTag],
            timeX.fromString(widgetData.value[TaskData.starttimeTag]),
            timeX.fromString(widgetData.value[TaskData.endtimeTag])
        ),
        id
    );
  }

}