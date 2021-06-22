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


  @override
  UserMadeWidgetBase<TaskData> createWidget(TaskData widgetInformation, WidgetId id) {
    return TaskWidget(
        widgetInformation,
        this.statusController,
        id,
        this.widgetDeletionFunction,
        JsonHandlerWidget.of(context).taskHandler,
        this.widget.identifier
    );
  }

  @override
  void initializeWidgets(BuildContext context) async {
    int highestIdInt = 0;
    if (await this.widget.startingWidgetsMap != null) {
      for (MapEntry widget in (await this.widget.startingWidgetsMap).entries) {

        WidgetId newId = WidgetId.fromString(widget.key);
        if (newId.number > highestIdInt) {
          highestIdInt = newId.number;
        }

        this.setState(() {
          List<UserMadeWidgetBase<TaskData>> newWidgets = this.widgets;
          newWidgets.add(createWidget(
              TaskData(
                  widget.value[WidgetData.titleTag],
                  widget.value[WidgetData.descriptionTag],
                  timeX.fromString(widget.value[TaskData.starttimeTag]),
                  timeX.fromString(widget.value[TaskData.endtimeTag])
              ),
              newId
          ));

          this.widgets = newWidgets;
        });
      }
    }
    this.nextWidgetId = highestIdInt + 1;
  }

  @override
  Widget build(BuildContext context) {

    return this.returnStandardBuild(context);
  }

  @override
  Future<UserMadeWidgetBase<WidgetData>> addWidget() async {
    TaskData widgetInformation = await CustomDialogs.showTaskEditDialog(context);
    if (widgetInformation != null) {
      return createWidget(widgetInformation, TaskId(this.nextWidgetId));
    }
  }

}