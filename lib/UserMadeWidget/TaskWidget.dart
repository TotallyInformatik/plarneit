import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/UserMadeWidget/ID.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';
import 'package:plarneit/utils/conversion.dart';

import '../UserInput/Dialogs.dart';

class TaskWidget extends UserMadeWidgetBase<TaskInformation> {

  static final double timeBottomMargin = 10;

   TaskWidget(TaskInformation widgetInformation, WidgetContainerStatusController statusController, WidgetId id, Function widgetDeletionFunction, JsonHandler jsonHandler, DateTime identifier, {Key key})
      : super(widgetInformation, statusController, id, widgetDeletionFunction, jsonHandler, identifier.xToString(), "task", key: key);

  @override
  State<StatefulWidget> createState() => _TaskWidgetState();

  @override
  Map<String, String> updateAddition(TaskInformation newWidgetInformation) {
    Map<String, String> result = {};
    result[TaskInformation.starttimeTag] = newWidgetInformation.starttime.xToString();
    result[TaskInformation.endtimeTag] = newWidgetInformation.endtime.xToString();

    return result;
  }
}

class _TaskWidgetState extends UserMadeWidgetBaseState<TaskInformation> {

  TimeOfDay _starttime;
  TimeOfDay _endtime;

  @override
  void updateAttributes (TaskInformation widgetInformation) {
    this.setState(() {
      this.title = widgetInformation.title;
      this.description = widgetInformation.description;
      this._starttime = widgetInformation.starttime;
      this._endtime = widgetInformation.endtime;
    });
  }

  @override
  Widget build(BuildContext context) {
      return this.returnStandardBuild(context, [
          Padding(
              padding: EdgeInsets.only(bottom: TaskWidget.timeBottomMargin),
              child: Text(
                  "${this._starttime.xToString()} - ${this._endtime.xToString()}",
                  style: Theme.of(context).accentTextTheme.bodyText1))
        ]
      );
  }

  @override
  void editingFunction() async {

    TaskInformation newWidgetInformation = await CustomDialogs.showTaskEditDialog(
        context,
        title: this.title,
        description: this.description,
        starttime: this._starttime,
        endtime: this._endtime
    );
    if (newWidgetInformation != null) {
      this.updateWidget(newWidgetInformation);
    }
  }
}
