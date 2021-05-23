import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/UrgencyTypes.dart';
import 'package:plarneit/utils/spacing.dart';
import 'UserMadeWidgets.dart';
import 'utils/constants.dart';

class DayWidgetContainer extends StatefulWidget {

  List<UserMadeWidget> startingWidgets;
  DateTime date;
  int nextWidgetId; // should always be set to startinWidgets.length

  DayWidgetContainer({Key key, this.startingWidgets, this.date, this.nextWidgetId}) : super(key: key);


  @override
  _DayWidgetContainerState createState() => _DayWidgetContainerState();



}

class _DayWidgetContainerState extends State<DayWidgetContainer> {

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    double containerHeight = widgetSize + widgetPadding;

    return Column(
        children: [
          Row(
            children: [
              IconButton(
                  icon: Icon(Icons.add_rounded),
                  tooltip: "Add task",
                  onPressed: () {
                    print("aaaa");
                    setState(() {
                      List<UserMadeWidget> newWidgets = [];
                      newWidgets.addAll(this.widget.startingWidgets);

                      newWidgets.add(UserMadeWidget(urgency: UrgencyTypes.NOT_URGENT_AT_ALL, title: "", description: "", id: this.widget.nextWidgetId, date: DateTime(1), starttime: TimeOfDay(hour: 13, minute: 2), endtime: TimeOfDay(hour: 13, minute: 2)));

                      this.widget.nextWidgetId++;
                      this.widget.startingWidgets = newWidgets;
                    });
                  }
              ),
            ],
          ),
          Container(
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
                      children: this.widget.startingWidgets.length == 0 ?
                      <Widget>[
                        Container(
                            width: widgetSize,
                            child: Text("Nothing to do for now!", style: Theme.of(context).textTheme.headline2)
                        )
                      ]
                          : this.widget.startingWidgets
                  )
              )
          )]
    );


  }


}