import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/UrgencyTypes.dart';
import 'package:plarneit/utils/spacing.dart';
import 'UserMadeWidgets.dart';
import 'utils/constants.dart';

class DayWidgetContainer extends ListView {
  DayWidgetContainer(this.widgets);

  final List<UserMadeWidget> widgets;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    double containerHeight = widgetSize + widgetPadding;


    return Container(
      constraints: BoxConstraints.expand(
        height: containerHeight + listContainerInnerPadding * 2,
      ),
        child: Scrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            padding: EdgeInsets.all(listContainerInnerPadding),
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              UserMadeWidget(UrgencyTypes.URGENT, "1", "This is a Widget"),
              UserMadeWidget(UrgencyTypes.URGENT, "2", "This is a Widget"),
              UserMadeWidget(UrgencyTypes.URGENT, "3", "This is a Widget"),
              UserMadeWidget(UrgencyTypes.URGENT, "4", "This is a Widget"),
              UserMadeWidget(UrgencyTypes.URGENT, "5", "This is a Widget"),
              UserMadeWidget(UrgencyTypes.URGENT, "6", "This is a Widget"),
              UserMadeWidget(UrgencyTypes.URGENT, "7", "This is a Widget"),
              UserMadeWidget(UrgencyTypes.URGENT, "8", "This is a Widget"),
            ]
          )
        )
    );

  }

}