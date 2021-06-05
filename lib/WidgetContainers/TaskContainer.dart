import 'package:flutter/material.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/UserInput/Dialogs.dart';
import 'package:plarneit/UserMadeWidget/ID.dart';
import 'package:plarneit/UserMadeWidget/TaskWidget.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';
import 'package:plarneit/utils/conversion.dart';

import '../IndentifierWidget.dart';
import 'WidgetContainer.dart';

class TaskContainer extends WidgetContainer {


  TaskContainer(Future<Map> startingWidgetsMap, DateTime date) : super(startingWidgetsMap, date, "tasks");

  @override
  State<StatefulWidget> createState() => _TaskContainerState();

}

class _TaskContainerState extends WidgetContainerState {

  @override
  void initializeWidgets(BuildContext context) async {
    int highestIdInt = 0;
    if (await this.widget.startingWidgetsMap != null) {
      for (MapEntry widget in (await this.widget.startingWidgetsMap).entries) {

        WidgetId newId = WidgetId.fromString(widget.key);
        if (newId.number > highestIdInt) {
          highestIdInt = newId.number;
        }

        this.widgets.add(TaskWidget(
            TaskInformation(
                widget.value[WidgetInformation.titleTag],
                widget.value[WidgetInformation.descriptionTag],
                timeX.fromString(widget.value[TaskInformation.starttimeTag]),
                timeX.fromString(widget.value[TaskInformation.endtimeTag])
            ),
            this.statusController,
            newId, // increments id count
            this.widgetDeletionFunction,
            JsonHandlerWidget.of(context).taskHandler,
            this.widget.date
        ));
      }
    }
    this.nextWidgetId = highestIdInt + 1;
  }

  @override
  Widget build(BuildContext context) {
    return this.returnStandardBuild(context);
  }

  @override
  Future<UserMadeWidgetBase<WidgetInformation>> addWidget() async {
    TaskInformation widgetInformation = await CustomDialogs.showTaskEditDialog(context);
    return TaskWidget(widgetInformation, this.statusController, TaskId(this.nextWidgetId), this.widgetDeletionFunction, JsonHandlerWidget.of(context).taskHandler, this.widget.date);
  }

}