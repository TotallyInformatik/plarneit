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
  final DateTime identifier;

  UserMadeWidgetBase(this.widgetInformation, this.statusController, this.id, this.widgetDeletionFunction, this.jsonHandler, this.identifier, {Key key}) : super(key: key) {
    initializeJson();
  }

  Map<String, String> returnJsonBase(WidgetInformation widgetInformation) {
    return {
      WidgetInformation.titleTag: this.widgetInformation.title,
      WidgetInformation.descriptionTag: this.widgetInformation.description
    };
  }

  void initializeJson() async {
    Map currentJsonContent = await this.jsonHandler.readFile();
    currentJsonContent.putIfAbsent(this.identifier, () => {}); // creates widgets for that day if needed...
    Map jsonBase = this.returnJsonBase(this.widgetInformation);
    jsonBase.addAll(this.updateAddition(this.widgetInformation));

    currentJsonContent[this.identifier].putIfAbsent(this.id, () => jsonBase); // this is not static programming (bruh)
    this.jsonHandler.writeToJson(currentJsonContent);
  }

  Map updateAddition(T newWidgetInformation);

  void updateJson(T newWidgetInformation) async {

    // TODO: does this work?

    Map toUpdate = this.returnJsonBase(this.widgetInformation);
    toUpdate.addAll(this.updateAddition(newWidgetInformation));

    Map currentJsonContent = await this.jsonHandler.readFile();
    currentJsonContent.updateAll((key, value) => toUpdate);
    this.jsonHandler.writeToJson(currentJsonContent);
  }

  @override
  State<StatefulWidget> createState();
}

abstract class UserMadeWidgetBaseState<T extends WidgetInformation> extends State<UserMadeWidgetBase> {

  Widget returnStandardBuild(
      BuildContext context,
      List<Widget> children,
      Function editingFunction,
      {Color noteColor}) {
    double containerSize = widgetSize + widgetPadding;

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
                              editingFunction();
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
