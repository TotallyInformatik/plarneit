import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/utils/spacing.dart';
import 'DayWidgetContainer.dart';
import 'utils/constants.dart';

class DayPage extends StatelessWidget {
  DayPage(this.date);

  final DateTime date;

  String constructDateStringFromDate(DateTime dateTime) {
    String suffix;
    switch (dateTime.day) {
      case 1:
        suffix = "st";
        break;
      case 2:
        suffix = "nd";
        break;
      case 3:
        suffix = "rd";
        break;
      default:
        suffix = "th";
        break;
    }

    return "${dateTime.day}${suffix} ${MONTH_TO_STRING[dateTime.month]}";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: 150.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                      constructDateStringFromDate(date),
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.left
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    DayWidgetContainer([], this.date)
                    // need to read from json file to set widgets
                  ],
                ),
              )
            ]
        )
    );

  }

}