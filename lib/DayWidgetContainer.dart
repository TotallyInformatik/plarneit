import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/UrgencyTypes.dart';
import 'package:plarneit/utils/spacing.dart';
import 'UserMadeWidgets.dart';
import 'utils/constants.dart';

class DayWidgetContainer extends StatefulWidget {

  List<UserMadeWidget> startingWidgets;
  DateTime date;

  DayWidgetContainer(List<UserMadeWidget> widgets, DateTime date) {
    this.startingWidgets = widgets;
    this.date = date;
  }


  @override
  _DayWidgetContainerState createState() => _DayWidgetContainerState(this.startingWidgets, this.date);



}

class _DayWidgetContainerState extends State<DayWidgetContainer> {

  List<UserMadeWidget> _widgets;
  final ScrollController _scrollController = ScrollController();
  DateTime date;

  _DayWidgetContainerState(List<UserMadeWidget> widgets, DateTime date) {
    this._widgets = widgets;
    this.date = date;
  }

  @override
  Widget build(BuildContext context) {

    double containerHeight = widgetSize + widgetPadding;

    return Column(
        children: [
          Row(
            children: [
              IconButton(
                  icon: Icon(Icons.add),
                  tooltip: "Add task",
                  onPressed: () {
                    print("aaaa");
                    setState(() {
                      List<UserMadeWidget> newWidgets = [];
                      newWidgets.addAll(_widgets);

                      _widgets = newWidgets;
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
                      children: _widgets.length == 0 ?
                      <Widget>[
                        Container(
                            width: widgetSize,
                            child: Text("Nothing to do for now!", style: Theme.of(context).textTheme.headline2)
                        )
                      ]
                          : _widgets
                  )
              )
          )]
    );


  }


}