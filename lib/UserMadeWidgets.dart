import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/utils/spacing.dart';
import 'Dialogs.dart';
import 'utils/constants.dart';

import 'UrgencyTypes.dart';

class UserMadeWidget extends StatefulWidget {

  UrgencyTypes urgency;
  String title;
  String description;
  int id;
  DateTime date;
  TimeOfDay starttime;
  TimeOfDay endtime;

  UserMadeWidget({Key key, this.urgency, this.title, this.description, this.id, this.date, this.starttime, this.endtime}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _UserMadeWidgetsState();



}

class _UserMadeWidgetsState extends State<UserMadeWidget> {

  @override
  Widget build(BuildContext context) {

    double containerSize = widgetSize + widgetPadding;

    return Container(
        width: containerSize,
        height: containerSize,
        child: Padding(
            padding: EdgeInsets.all(widgetPadding),
            child: InkWell(
                onTap: () async {
                  print("tapped");
                  print("result" + (await showEditDialog(context)).toString());
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: URGENCY_TO_COLOR[this.widget.urgency],
                        borderRadius: BorderRadius.all(Radius.circular(widgetBorderRadius))
                    ),
                    width: widgetSize,
                    height: widgetSize,
                    child: Padding(
                        padding: EdgeInsets.all(widgetInnerPadding),
                        child: Text(this.widget.title)
                    )
                )
            )
        )
    );

  }

}