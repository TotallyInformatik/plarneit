import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/DayPageDate.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/UrgencyTypes.dart';
import 'package:plarneit/UserMadeWidget/NoteWidget.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';
import 'package:plarneit/utils/conversion.dart';
import 'package:plarneit/utils/spacing.dart';
import 'Dialogs.dart';
import 'UserMadeWidget/TaskWidget.dart';
import 'UserMadeWidget/UserMadeWidgetBase.dart';
import 'utils/constants.dart';

enum WidgetContainerTypes {
  TASKS,
  NOTES
}

class WidgetContainer extends StatefulWidget {

  final List<UserMadeWidgetBase> startingWidgets;
  final DateTime date;
  final int nextWidgetId; // should always be set to startingWidgets.length
  final String title;
  final WidgetContainerTypes type;

  const WidgetContainer(this.startingWidgets, this.date, this.nextWidgetId, this.title, this.type, {Key key}) : super(key: key);


  @override
  _WidgetContainerState createState() => _WidgetContainerState();

}

class _WidgetContainerState extends State<WidgetContainer> {


  final ScrollController _scrollController = ScrollController();
  int _nextWidgetId;
  List<UserMadeWidgetBase> _widgets;
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
                    tooltip: "Add ${enumToString(this.widget.type).toLowerCase()}",
                    onPressed: () async {
                      List<UserMadeWidgetBase> newWidgets = [];
                      newWidgets.addAll(this._widgets);


                      switch (this.widget.type) {
                        case WidgetContainerTypes.TASKS:
                          WidgetInformation widgetInformation = await showTaskEditDialog(context);
                          if (widgetInformation != null) { newWidgets.add(TaskWidget(widgetInformation, this._eController, this._nextWidgetId)); }
                          break;
                        case WidgetContainerTypes.NOTES:
                          WidgetInformation widgetInformation = await showNoteEditDialog(context);
                          if (widgetInformation != null) { newWidgets.add(NoteWidget(widgetInformation, this._eController, this._nextWidgetId)); }
                          break;
                      }

                      setState(() {
                        this._nextWidgetId++;
                        this._widgets = newWidgets;
                        print(this._widgets.toString());
                      });
                    }
                ),
                IconButton(
                  iconSize: iconSize - 15,
                  icon: this._eController.isEditing ? Icon(Icons.edit_off) : Icon(Icons.edit),
                  tooltip: "Edit ${enumToString(this.widget.type).toLowerCase()}",
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
                                child: Text("No ${enumToString(this.widget.type).toLowerCase()} for now!", style: Theme.of(context).primaryTextTheme.bodyText2)
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