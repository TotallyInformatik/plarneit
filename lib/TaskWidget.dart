import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/DayWidgetContainer.dart';
import 'package:plarneit/EditingController.dart';
import 'package:plarneit/utils/conversion.dart';
import 'package:plarneit/utils/spacing.dart';
import 'Dialogs.dart';
import 'utils/constants.dart';

import 'UrgencyTypes.dart';

class TaskWidget extends StatefulWidget {

  static final titleTag = "title";
  static final descriptionTag = "description";
  static final starttimeTag = "starttime";
  static final endtimeTag = "endtime";

  final Map widgetInformation;
  final int id;
  final DateTime date;
  final EditingController eController;

  const TaskWidget({Key key, this.widgetInformation, this.date, this.id, this.eController}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _TaskWidget();

}

class _TaskWidget extends State<TaskWidget> {

  String _title;
  String _description;
  TimeOfDay _starttime;
  TimeOfDay _endtime;
  EditingController _editingController;

  void _updateAttributes(Map widgetInformation) {
    this.setState(() {
      this._title = widgetInformation[TaskWidget.titleTag];
      this._description = widgetInformation[TaskWidget.descriptionTag];
      this._starttime = widgetInformation[TaskWidget.starttimeTag];
      this._endtime = widgetInformation[TaskWidget.endtimeTag];
    });
  }

  @override
  void initState() {
    super.initState();
    this._updateAttributes(this.widget.widgetInformation);
    this._editingController = this.widget.eController;
  }

  @override
  Widget build(BuildContext context) {

    double containerSize = widgetSize + widgetPadding;

    return Container(
        height: containerSize,
        width: containerSize,
        child: Padding(
          padding: EdgeInsets.all(widgetPadding),
          child: Material(
            child: Ink(
              width: widgetSize,
              height: widgetSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(widgetBorderRadius)),
                color: TASK_COLOR,
              ),
              child: InkWell(
                splashColor: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.all(Radius.circular(widgetBorderRadius)),
                onTap: () async {
                  if (this._editingController.isEditing) {

                    Map newWidgetInformation = await showEditDialog(context, title: this._title, description: this._description, starttime: this._starttime, endtime: this._endtime);
                    if (newWidgetInformation != null) {
                      this._updateAttributes(newWidgetInformation);
                    }

                  }

                },
                child: Container(
                  width: widgetSize,
                  height: widgetSize,
                  child: ListView(
                      padding: EdgeInsets.all(widgetInnerPadding),
                      scrollDirection: Axis.vertical,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(bottom: timeBottomMargin),
                            child: Text("${timeToString(this._starttime)} - ${timeToString(this._endtime)}", style: Theme.of(context).accentTextTheme.bodyText1)
                        ),
                        Text(this._title, style: Theme.of(context).accentTextTheme.headline5),
                        Text(this._description, style: Theme.of(context).accentTextTheme.bodyText1)
                      ]
                  )
                )
              )
            )
          )

        )
    );

  }

}