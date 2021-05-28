import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/DayWidgetContainer.dart';
import 'package:plarneit/EditingController.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';
import 'package:plarneit/utils/conversion.dart';
import 'package:plarneit/utils/spacing.dart';
import '../Dialogs.dart';
import '../utils/constants.dart';

import '../UrgencyTypes.dart';

class TaskWidget extends StatefulWidget {

  final WidgetInformation widgetInformation;
  final int id;
  final EditingController eController;

  const TaskWidget(this.widgetInformation, this.eController, this.id, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _TaskWidget();

}

class _TaskWidget extends State<TaskWidget> {

  String _title;
  String _description;
  TimeOfDay _starttime;
  TimeOfDay _endtime;
  bool _animationStarted = false;

  void _updateAttributes(TaskInformation widgetInformation) {
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
    this._updateAttributes(this.widget.widgetInformation);
    this.initAnimation();
  }

  void initAnimation() async {
    await Future.delayed(Duration(milliseconds: 100));
    this.setState(() {
      this._animationStarted = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedOpacity(
      duration: Duration(milliseconds: 1000),
      opacity: !_animationStarted ? 0 : 1,
      child: UserMadeWidgetBase.returnStandardUMWidgetStructure(context, [
        Padding(
          padding: EdgeInsets.only(bottom: timeBottomMargin),
          child: Text("${timeToString(this._starttime)} - ${timeToString(this._endtime)}", style: Theme.of(context).accentTextTheme.bodyText1)
        ),
        Text(this._title, style: Theme.of(context).accentTextTheme.headline5),
        Text(this._description, style: Theme.of(context).accentTextTheme.bodyText1)
      ], () async {
        if (this.widget.eController.isEditing) {

          TaskInformation newWidgetInformation = await showTaskEditDialog(context, title: this._title, description: this._description, starttime: this._starttime, endtime: this._endtime);
          if (newWidgetInformation != null) {
            this._updateAttributes(newWidgetInformation);
          }
        }

      }, this.widget.eController)
    );
  }

}