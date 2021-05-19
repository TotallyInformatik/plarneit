import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/utils/spacing.dart';
import 'utils/constants.dart';

import 'UrgencyTypes.dart';

class UserMadeWidget extends StatelessWidget {
  UserMadeWidget(this.urgency, this.title, this.description);

  final UrgencyTypes urgency;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {

    double containerSize = widgetSize + widgetPadding;

    return Container(
      width: containerSize,
      height: containerSize,
      child: Padding(
        padding: EdgeInsets.all(widgetPadding),
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
      );
  }

}