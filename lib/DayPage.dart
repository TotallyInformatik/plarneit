import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/utils/conversion.dart';
import 'package:plarneit/utils/spacing.dart';
import 'DayWidgetContainer.dart';
import 'utils/constants.dart';

class DayPage extends StatelessWidget {
  DayPage(this.date);

  final DateTime date;

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
                      dateToText(date),
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.left
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    DayWidgetContainer(startingWidgets: [], date: this.date, nextWidgetId: 0)
                    // need to read from json file to set widgets
                  ],
                ),
              )
            ]
        )
    );

  }

}