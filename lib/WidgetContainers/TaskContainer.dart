import 'package:flutter/material.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/Dialogs.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/UserMadeWidget/TaskWidget.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';
import 'package:plarneit/utils/constants.dart';
import 'package:plarneit/utils/conversion.dart';

import '../IndentifierWidget.dart';
import 'WidgetContainer.dart';

class TaskContainer extends WidgetContainer {


  TaskContainer(Future<List> startingWidgetsMap, DateTime date) : super(startingWidgetsMap, date, "tasks");

  @override
  State<StatefulWidget> createState() => _TaskContainerState();

}

class _TaskContainerState extends WidgetContainerState {

  @override
  void initializeWidgets(BuildContext context) async {
    print("starting Widgets: ${await this.widget.startingWidgetsMap}");
    if (await this.widget.startingWidgetsMap != null) {
      for (Map widget in await this.widget.startingWidgetsMap) {
        this.widgets.add(TaskWidget(
            TaskInformation(
                widget[WidgetInformation.titleTag],
                widget[WidgetInformation.descriptionTag],
                timeX.fromString(widget[TaskInformation.starttimeTag]),
                timeX.fromString(widget[TaskInformation.endtimeTag])
            ),
            this.statusController,
            this.nextWidgetId++, // increments id count
            this.widgetDeletionFunction,
            JsonHandlerWidget.of(context).taskHandler,
            this.widget.date
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return this.returnStandardBuild(context);
  }

  @override
  Future<UserMadeWidgetBase<WidgetInformation>> addWidget() async {
    WidgetInformation widgetInformation = await showTaskEditDialog(context);
    return TaskWidget(widgetInformation, this.statusController, this.nextWidgetId, this.widgetDeletionFunction, JsonHandlerWidget.of(context).taskHandler, this.widget.date);
  }

}