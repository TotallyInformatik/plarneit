import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/DayPageDate.dart';
import 'package:plarneit/EditingController.dart';
import 'package:plarneit/UrgencyTypes.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';
import 'package:plarneit/utils/spacing.dart';
import 'Dialogs.dart';
import 'UserMadeWidget/TaskWidget.dart';
import 'UserMadeWidget/UserMadeWidgetBase.dart';
import 'utils/constants.dart';

class DayWidgetContainer extends StatefulWidget {

  final List<TaskWidget> startingWidgets;
  final DateTime date;
  final int nextWidgetId; // should always be set to startingWidgets.length
  final String title;

  const DayWidgetContainer({Key key, this.startingWidgets, this.date, this.nextWidgetId, this.title}) : super(key: key);


  @override
  _DayWidgetContainerState createState() => _DayWidgetContainerState();



}

class _DayWidgetContainerState extends State<DayWidgetContainer> {


  final ScrollController _scrollController = ScrollController();
  int _nextWidgetId;
  List<StatefulWidget> _widgets;
  EditingController _eController = EditingController();

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
          Padding(
            padding: EdgeInsets.only(left: sidePadding),
            child: Row(
              children: [
                Text(this.widget.title, style: Theme.of(context).primaryTextTheme.headline2,),
                IconButton(
                    iconSize: iconSize,
                    icon: Icon(Icons.add_rounded),
                    tooltip: "Add task",
                    onPressed: () async {
                      TaskInformation widgetInformation = await showTaskEditDialog(context);

                      if (widgetInformation != null) {

                        setState(() {
                          List<StatefulWidget> newWidgets = [];
                          newWidgets.addAll(this._widgets);

                          // TODO: use if statement to decide whether to add Note WIdget or TaskWIdget

                          newWidgets.add(TaskWidget(widgetInformation, this._eController, this._nextWidgetId));

                          this._nextWidgetId++;
                          this._widgets = newWidgets;
                          print(this._widgets);
                        });

                      }
                    }
                ),
                IconButton(
                  iconSize: iconSize - 15,
                  icon: this._eController.isEditing ? Icon(Icons.edit_off) : Icon(Icons.edit),
                  tooltip: "Edit task", // TODO: change this
                  onPressed: () {
                    this.setState(() {
                      this._eController.reverseIsEditing();
                    });
                  },
                )
              ],
            )
          ),
          Container(
              constraints: BoxConstraints.expand(
                height: containerHeight + listContainerInnerPadding * 2,
              ),
              child: Scrollbar(
                  isAlwaysShown: true,
                  controller: _scrollController,
                  child: DayPageDate(
                      date: this.widget.date,
                      child: ListView(
                          controller: _scrollController,
                          padding: EdgeInsets.all(listContainerInnerPadding),
                          scrollDirection: Axis.horizontal,
                          children: this._widgets.length == 0 ?
                          <Widget>[
                            Container(
                                width: widgetSize,
                                child: Text("No Tasks for now!", style: Theme.of(context).primaryTextTheme.bodyText2) // TODO: change this
                            )
                          ]
                              : this._widgets
                      )
                  ),
              )
          )]
    );


  }


}