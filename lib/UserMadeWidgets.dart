import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/utils/spacing.dart';
import 'Dialogs.dart';
import 'utils/constants.dart';

import 'UrgencyTypes.dart';

class UserMadeWidget extends StatefulWidget {

  final UrgencyTypes urgency;
  final String title;
  final String description;
  final int id;
  final DateTime date;
  final TimeOfDay starttime;
  final TimeOfDay endtime;

  const UserMadeWidget({Key key, this.urgency, this.title, this.description, this.id, this.date, this.starttime, this.endtime}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _UserMadeWidgetsState();



}

class _UserMadeWidgetsState extends State<UserMadeWidget> {

  UrgencyTypes _urgency;
  String _title;
  String _description;
  int _id;
  DateTime _date;
  TimeOfDay _starttime;
  TimeOfDay _endtime;

  @override
  void initState() {
    super.initState();
    this._urgency = this.widget.urgency;
    this._title = this.widget.title;
    this._description = this.widget.description;
    this._id = this.widget.id; // TODO: is this needed?
    this._date = this.widget.date;
    this._starttime = this.widget.starttime;
    this._endtime = this.widget.endtime;
  }

  @override
  Widget build(BuildContext context) {

    double containerSize = widgetSize + widgetPadding;

    return Container(
        width: containerSize,
        height: containerSize,
        child: Padding(
          padding: EdgeInsets.all(widgetPadding),
          child: Material(
            child: Ink(
              width: widgetSize,
              height: widgetSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(widgetBorderRadius)),
                color: URGENCY_TO_COLOR[this._urgency],
              ),
              child: InkWell(
                splashColor: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.all(Radius.circular(widgetBorderRadius)),
                onTap: () async {
                  await Future.delayed(const Duration(milliseconds: 100), () {});
                  print("result" + (await showEditDialog(context)).toString());
                },
                child: Container(
                  width: widgetSize,
                  height: widgetSize,
                  child: Padding(
                      padding: EdgeInsets.all(widgetInnerPadding),
                      child: Text(this._title)
                  )
                )
              )
            )
          )

        )
    );

  }

}