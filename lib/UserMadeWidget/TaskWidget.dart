import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/Data/WidgetData.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/UserInput/Dialogs.dart';
import 'package:plarneit/UserMadeWidget/ID.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';
import 'package:plarneit/utils/conversion.dart';

class TaskWidget extends UserMadeWidgetBase<TaskData> {

  static final double timeBottomMargin = 5;

   TaskWidget(TaskData widgetInformation, WidgetContainerStatusController statusController, WidgetId id, Function widgetDeletionFunction, JsonHandler jsonHandler, DateTime identifier, {Key key})
      : super(widgetInformation, statusController, id, widgetDeletionFunction, jsonHandler, identifier.xToString(), key: key);

  @override
  State<StatefulWidget> createState() => _TaskWidgetState();

}

class _TaskWidgetState extends UserMadeWidgetBaseState<TaskData> {

  TimeOfDay _starttime;
  TimeOfDay _endtime;

  @override
  void updateAttributes (TaskData widgetInformation) {
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

    TaskData newWidgetInformation = await CustomDialogs.showTaskEditDialog(
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
