import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/Data/WidgetData.dart';
import 'package:plarneit/Pages/ContainerPages/DayPage.dart';
import 'package:plarneit/UserMadeWidget/ID.dart';
import 'package:plarneit/UserMadeWidget/UserMadeWidgetBase.dart';

///
/// @author: Rui Zhang (TotallyInformatik)
///
/// An abstract class defining the way a widget container should work.
///

abstract class WidgetContainer extends StatefulWidget {

  // Layout attributes
  static final double widgetSize = UserMadeWidgetBase.widgetSize;
  static final double widgetPadding = UserMadeWidgetBase.widgetMargin;
  static final double sidePadding = DayPage.listContainerInnerPadding;
  static final Color widgetContainerBackgroundColor = Color.fromRGBO(240, 240, 240, 1);


  final Future<Map> startingWidgetsMap;
  final DateTime identifier;
  final String widgetName;

  final ScrollController _scrollController = ScrollController();

  WidgetContainer(this.startingWidgetsMap, this.identifier, this.widgetName, {Key key}) : super(key: key);

}

abstract class WidgetContainerState<T extends WidgetData> extends State<WidgetContainer> {

  List<UserMadeWidgetBase<T>> widgets;
  final WidgetContainerStatusController statusController = WidgetContainerStatusController();



  /// should always be async
  Future<UserMadeWidgetBase> addWidget();
  UserMadeWidgetBase<T> createWidget(T widgetInformation, WidgetId id);
  UserMadeWidgetBase<T> initializeWidgetFromMap(MapEntry widgetData);

  IconButton controllerIconButton(double sizeOffset, ContainerStatus status, IconData standrdIcon, IconData turnOffIcon) {
    return IconButton(
      iconSize: IconTheme.of(context).size - sizeOffset * IconTheme.of(context).size,
      icon: this.statusController.value == status ? Icon(turnOffIcon) : Icon(standrdIcon),
      onPressed: () {
        this.setState(() {
          this.statusController.toggleStatus(status);
        });
      },
    );
  }



  void initializeWidgets(BuildContext context) async {
    List<UserMadeWidgetBase<T>> initializedWidgetList = [];
    if (await this.widget.startingWidgetsMap != null) {
      for (MapEntry widgetData in (await this.widget.startingWidgetsMap).entries) {
          UserMadeWidgetBase<T> newWidget = initializeWidgetFromMap(widgetData);
          if (newWidget != null) {
            initializedWidgetList.add(newWidget);
          }
      }
    }

    setState(() {
      this.widgets = initializedWidgetList;
    });
  }

  @override
  void initState() {
    super.initState();
    this.widgets = [];
    this.initializeWidgets(this.context);
  }

  void widgetDeletionFunction(UserMadeWidgetBase widget) {

    // this function works correctly

    setState(() {
      List<UserMadeWidgetBase<T>> newWidgets = [];
      newWidgets.addAll(this.widgets);
      newWidgets.remove(widget);
      this.widgets = newWidgets;
    });

    widget.deleteJson();

  }

  Widget returnStandardBuild(BuildContext context) {

    double containerHeight = WidgetContainer.widgetSize + WidgetContainer.widgetPadding;

    Widget result = Column(
        children: [
          Container(
            color: WidgetContainer.widgetContainerBackgroundColor,
            child: Padding(
                padding: EdgeInsets.only(left: WidgetContainer.sidePadding),
                child: Row(
                  children: [
                    Text(this.widget.widgetName, style: Theme.of(context).primaryTextTheme.headline2),
                    IconButton(
                        iconSize: IconTheme.of(context).size,
                        icon: Icon(Icons.add_rounded),
                        onPressed: () async {

                          List<UserMadeWidgetBase<T>> newWidgets = [];
                          newWidgets.addAll(this.widgets);
                          UserMadeWidgetBase newWidget = await this.addWidget();
                          if (newWidget != null) {
                            newWidgets.add(newWidget);
                          }

                          this.setState(() {
                            this.widgets = newWidgets;
                          });

                        }
                    ),
                    controllerIconButton(0.15, ContainerStatus.EDITING, Icons.edit_rounded, Icons.edit_off),
                    controllerIconButton(0.10, ContainerStatus.DELETING, Icons.delete_rounded, Icons.delete_forever_rounded)
                  ],
                )
            )
          ),
          Container(
              constraints: BoxConstraints.expand(
                height: containerHeight + WidgetContainer.sidePadding * 2,
              ),
              child: Scrollbar(
                isAlwaysShown: true,
                controller: this.widget._scrollController,
                child: ListView.builder(
                  controller: this.widget._scrollController,
                  padding: EdgeInsets.all(WidgetContainer.sidePadding),
                  scrollDirection: Axis.horizontal,
                  itemCount: this.widgets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return this.widgets[index];
                  },
                ),
              )
          )]
    );

    return result;

  }


}