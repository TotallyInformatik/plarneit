import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';
import 'package:plarneit/utils/conversion.dart';

import '../Dialogs.dart';
import '../utils/constants.dart';

class TaskWidget extends UserMadeWidgetBase {

  const TaskWidget(WidgetInformation widgetInformation, WidgetContainerStatusController statusController, int id, Function widgetDeletionFunction, {Key key})
      : super(widgetInformation, statusController, id, widgetDeletionFunction, key: key);

  @override
  State<StatefulWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends UserMadeWidgetBaseState<TaskInformation> {
  String _title;
  String _description;
  TimeOfDay _starttime;
  TimeOfDay _endtime;

  @override
  void updateAttributes(TaskInformation widgetInformation) {
    this.setState(() {
      this._title = widgetInformation.title;
      this._description = widgetInformation.description;
      this._starttime = widgetInformation.starttime;
      this._endtime = widgetInformation.endtime;
    });
  }

  @override
  void initState() {
    super.initState();
    this.updateAttributes(this.widget.widgetInformation);
  }

  @override
  Widget build(BuildContext context) {
      return this.returnStandardBuild(context, [
          Padding(
              padding: EdgeInsets.only(bottom: timeBottomMargin),
              child: Text(
                  "${timeToString(this._starttime)} - ${timeToString(this._endtime)}",
                  style: Theme.of(context).accentTextTheme.bodyText1)),
          Text(this._title, style: Theme.of(context).accentTextTheme.headline5),
          Text(this._description,
              style: Theme.of(context).accentTextTheme.bodyText1)
        ], () async {

          // editing function

          TaskInformation newWidgetInformation = await showTaskEditDialog(
              context,
              title: this._title,
              description: this._description,
              starttime: this._starttime,
              endtime: this._endtime);
          if (newWidgetInformation != null) {
            this.updateAttributes(newWidgetInformation);
          }
        }
      );
  }
}
