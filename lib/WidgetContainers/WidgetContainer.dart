import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/DayPage.dart';
import 'package:plarneit/IndentifierWidget.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/UserMadeWidget/NoteWidget.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';
import 'package:plarneit/utils/conversion.dart';
import '../UserInput/Dialogs.dart';
import '../UserMadeWidget/TaskWidget.dart';
import '../UserMadeWidget/UserMadeWidgetBase.dart';

abstract class WidgetContainer extends StatefulWidget {

  // Layout attributes
  static final double iconSize = 40;
  static final double widgetSize = UserMadeWidgetBase.widgetSize;
  static final double widgetPadding = UserMadeWidgetBase.widgetPadding;
  static final double sidePadding = DayPage.listContainerInnerPadding;
  static final Color widgetContainerBackgroundColor = Color.fromRGBO(240, 240, 240, 0);


  final Future<Map> startingWidgetsMap;
  final DateTime date; // should always be set to startingWidgets.length
  final String widgetName;

  final ScrollController _scrollController = ScrollController();

  WidgetContainer(this.startingWidgetsMap, this.date, this.widgetName, {Key key}) : super(key: key);

}

abstract class WidgetContainerState extends State<WidgetContainer> {

  int nextWidgetId;
  List<UserMadeWidgetBase> widgets;
  final WidgetContainerStatusController statusController = WidgetContainerStatusController();

  IconButton controllerIconButton(int sizeOffset, ContainerStatus status, IconData standrdIcon, IconData turnOffIcon) {
    return IconButton(
      iconSize: WidgetContainer.iconSize - sizeOffset,
      icon: this.statusController.value == status ? Icon(turnOffIcon) : Icon(standrdIcon),
      onPressed: () {
        this.setState(() {
          this.statusController.toggleStatus(status);
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    this.nextWidgetId = 1;
    this.widgets = [];
    this.initializeWidgets(this.context);
  }

  void widgetDeletionFunction(UserMadeWidgetBase widget) {

    // this function works correctly

    int toDeleteIndex;

    setState(() {
      List<UserMadeWidgetBase> newWidgets = [];
      newWidgets.addAll(this.widgets);

      UserMadeWidgetBase toDelete;
      for (UserMadeWidgetBase currentWidget in newWidgets) {

        if (currentWidget != null) {
          if (currentWidget.id == widget.id) {
            toDelete = currentWidget;
            break;
          }
        }

      }

      toDeleteIndex = newWidgets.indexOf(toDelete);
      newWidgets[toDeleteIndex] = null;
      this.widgets = newWidgets;
      // this.nextWidgetId--; explicitly DON'T do this
    });

    widget.deleteJson();

  }

  void initializeWidgets(BuildContext context);

  /// should always be async
  Future<UserMadeWidgetBase> addWidget();

  Widget returnStandardBuild(BuildContext context) {

    double containerHeight = WidgetContainer.widgetSize + WidgetContainer.widgetPadding;
    List<int> toDeleteIndex = [];

    Widget result = Column(
        children: [
          Padding(
              padding: EdgeInsets.only(left: WidgetContainer.sidePadding),
              child: Row(
                children: [
                  Text(this.widget.widgetName, style: Theme.of(context).primaryTextTheme.headline2),
                  IconButton(
                      iconSize: WidgetContainer.iconSize,
                      icon: Icon(Icons.add_rounded),
                      tooltip: "Add ${this.widget.widgetName}",
                      onPressed: () async {
                        List<UserMadeWidgetBase> newWidgets = [];
                        newWidgets.addAll(this.widgets);
                        newWidgets.add(await this.addWidget());
                        this.widgets = newWidgets;

                        setState(() {
                          this.nextWidgetId++;
                        });
                      }
                  ),
                  controllerIconButton(15, ContainerStatus.EDITING, Icons.edit_rounded, Icons.edit_off),
                  controllerIconButton(10, ContainerStatus.DELETING, Icons.delete_rounded, Icons.delete_forever_rounded)
                ],
              )
          ),
          Container(
              constraints: BoxConstraints.expand(
                height: containerHeight + WidgetContainer.sidePadding * 2,
              ),
              child: Scrollbar(
                isAlwaysShown: true,
                controller: this.widget._scrollController,
                child: Identifier(
                    identifier: this.widget.date,
                    child: ListView.builder(
                      controller: this.widget._scrollController,
                      padding: EdgeInsets.all(WidgetContainer.sidePadding),
                      scrollDirection: Axis.horizontal,
                      itemCount: this.widgets.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (this.widgets[index] == null) {
                          toDeleteIndex.add(index);
                          return Container();
                        } else {
                          return this.widgets[index];
                        }
                      },
                    )
                ),
              )
          )]
    );

    for (int i in toDeleteIndex) {
      this.widgets.removeAt(i);
    }

    return result;

  }


}