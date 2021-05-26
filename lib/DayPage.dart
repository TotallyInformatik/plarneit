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
                backgroundColor: TASK_COLOR,
                pinned: true,
                expandedHeight: 150.0,
                collapsedHeight: 80,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  titlePadding: EdgeInsets.only(left: listContainerInnerPadding, bottom: 30),
                  title: Text(
                      dateToText(date),
                      style: Theme.of(context).accentTextTheme.headline1,
                      textAlign: TextAlign.left
                  ),
                  background: Image(image: AssetImage("assets/images/forest1.jpg"), fit: BoxFit.cover,),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    DayWidgetContainer(startingWidgets: [], date: this.date, nextWidgetId: 0, title: "Tasks:"),
                    DayWidgetContainer(startingWidgets: [], date: this.date, nextWidgetId: 0, title: "Notes:")
                  ],
                ),
              )
            ]
        )
    );

  }

}