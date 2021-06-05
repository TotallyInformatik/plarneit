import 'package:flutter/material.dart';
import 'package:plarneit/IndentifierWidget.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/utils/constants.dart';

// TODO: test


abstract class UserMadeWidgetBase<T extends WidgetInformation> extends StatefulWidget {

  final T widgetInformation;
  final int id;
  final WidgetContainerStatusController statusController;
  final Function widgetDeletionFunction;
  final JsonHandler jsonHandler;
  final String identifier;
  final String widgetIdPrefix;

  UserMadeWidgetBase(this.widgetInformation, this.statusController, this.id, this.widgetDeletionFunction, this.jsonHandler, this.identifier, this.widgetIdPrefix, {Key key}) : super(key: key) {
    initializeJson();
  }

  String returnIdString() {
    return "${this.widgetIdPrefix}-${this.id}";
  }

  Map<String, String> returnJsonBase(WidgetInformation widgetInformation) {
    Map<String, String> result = {};
    result[WidgetInformation.titleTag] = widgetInformation.title;
    result[WidgetInformation.descriptionTag] = widgetInformation.description;
    return result;
  }

  void initializeJson() async {
    Map<String, dynamic> currentJsonContent = await this.jsonHandler.readFile();
    currentJsonContent.putIfAbsent(this.identifier, () => Map<String, dynamic>()); // creates widgets for that day if needed...
    Map<String, String> jsonBase = this.returnJsonBase(this.widgetInformation);
    jsonBase.addAll(this.updateAddition(this.widgetInformation));

    currentJsonContent[this.identifier].putIfAbsent(returnIdString(), () => jsonBase); // this is not static programming (bruh)
    this.jsonHandler.writeToJson(currentJsonContent);
  }

  void updateJson(T newWidgetInformation) async {

    Map<String, dynamic> toUpdate = this.returnJsonBase(newWidgetInformation);
    toUpdate.addAll(this.updateAddition(newWidgetInformation));

    Map<String, dynamic> currentJsonContent = await this.jsonHandler.readFile();
    currentJsonContent[this.identifier][this.returnIdString()] = toUpdate;
    this.jsonHandler.writeToJson(currentJsonContent);
  }

  Map updateAddition(T newWidgetInformation);


}

abstract class UserMadeWidgetBaseState<T extends WidgetInformation> extends State<UserMadeWidgetBase> {

  String title;
  String description;

  @override
  void initState() {
    super.initState();
    this.updateAttributes(this.widget.widgetInformation);
  }

  /// should always be async
  void editingFunction();

  Widget returnStandardBuild(
      BuildContext context,
      List<Widget> additionalChildren,
      {Color noteColor}) {

    double containerSize = widgetSize + widgetPadding;

    List<Widget> children = [
      Text(this.title, style: Theme.of(context).accentTextTheme.headline5),
      Text(this.description, style: Theme.of(context).accentTextTheme.bodyText1)
    ];

    children.addAll(additionalChildren);

    return Container(
        height: containerSize,
        width: containerSize,
        child: Padding(
            padding: EdgeInsets.all(widgetPadding),
            child: Material(
                child: Ink(
                    width: widgetSize,
                    height: widgetSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(widgetBorderRadius)),
                      color: noteColor != null ? noteColor : TASK_COLOR,
                    ),
                    child: InkWell(
                        splashColor: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.all(Radius.circular(widgetBorderRadius)),
                        onTap: () {
                          switch(this.widget.statusController.value) {
                            case ContainerStatus.EDITING:
                              this.editingFunction();
                              break;
                            case ContainerStatus.DELETING:
                              this.widget.widgetDeletionFunction(this.widget);
                              break;
                            case ContainerStatus.STANDBY:
                              break;
                          }
                        },
                        child: Container(
                            width: widgetSize,
                            height: widgetSize,
                            child: ListView(
                                padding: EdgeInsets.all(widgetInnerPadding),
                                scrollDirection: Axis.vertical,
                                children: children
                            )
                        )
                    )
                )
            )

        )
    );

  }

  // should be used in the editing function
  void updateWidget(T widgetInformation) {
    this.updateAttributes(widgetInformation);
    this.widget.updateJson(widgetInformation);
  }

  void updateAttributes(T widgetInformation);

}
