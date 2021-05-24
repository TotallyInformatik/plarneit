import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/UrgencyTypes.dart';
import 'package:plarneit/utils/spacing.dart';
import 'Dialogs.dart';
import 'UserMadeWidgets.dart';
import 'utils/constants.dart';

class DayWidgetContainer extends StatefulWidget {

  final List<UserMadeWidget> startingWidgets;
  final DateTime date;
  final int nextWidgetId; // should always be set to startingWidgets.length

  const DayWidgetContainer({Key key, this.startingWidgets, this.date, this.nextWidgetId}) : super(key: key);


  @override
  _DayWidgetContainerState createState() => _DayWidgetContainerState();



}

class _DayWidgetContainerState extends State<DayWidgetContainer> {


  final ScrollController _scrollController = ScrollController();
  int _nextWidgetId;
  List<UserMadeWidget> _widgets;

  @override
  void initState() {
    super.initState();
    this._nextWidgetId = this.widget.nextWidgetId;
    this._widgets = this.widget.startingWidgets;

  }

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
                  onPressed: () async {
                    Map widgetInformation = await showEditDialog(context);

                    if (widgetInformation.length > 0) {

                      setState(() {
                        List<UserMadeWidget> newWidgets = [];
                        newWidgets.addAll(this._widgets);

                        newWidgets.add(UserMadeWidget(
                          urgency: UrgencyTypes.NOT_URGENT_AT_ALL,
                          id: this.widget.nextWidgetId,
                          date: this.widget.date,
                          title: widgetInformation["title"],


                        ));

                        this._nextWidgetId++;
                        this._widgets = newWidgets;
                        print(this._widgets);
                      });

                    }
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
                      children: this._widgets.length == 0 ?
                      <Widget>[
                        Container(
                            width: widgetSize,
                            child: Text("Nothing to do for now!", style: Theme.of(context).textTheme.headline2)
                        )
                      ]
                          : this._widgets
                  )
              )
          )]
    );


  }


}