import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/utils/spacing.dart';
import 'utils/constants.dart';

import 'UrgencyTypes.dart';

class UserMadeWidget extends StatelessWidget {
  UserMadeWidget(this.urgency, this.title, this.description, this.id, this.date, this.starttime, this.endtime);

  final UrgencyTypes urgency;
  final String title;
  final String description;
  final int id;
  final DateTime date;
  final TimeOfDay starttime;
  final TimeOfDay endtime;


  @override
  Widget build(BuildContext context) {

    double containerSize = widgetSize + widgetPadding;

    return Container(
      width: containerSize,
      height: containerSize,
      child: Padding(
        padding: EdgeInsets.all(widgetPadding),
        child: InkWell(
            onTap: () {
              print("lol");
            },
            child: Container(
                  decoration: BoxDecoration(
                      color: URGENCY_TO_COLOR[this.urgency],
                      borderRadius: BorderRadius.all(Radius.circular(widgetBorderRadius))
                  ),
                  width: widgetSize,
                  height: widgetSize,
                  child: Padding(
                    padding: EdgeInsets.all(widgetInnerPadding),
                    child: Text(title)
                  )
              )
            )
        )
      );

  }

}