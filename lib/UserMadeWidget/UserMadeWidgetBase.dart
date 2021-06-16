import 'package:flutter/material.dart';
import 'package:plarneit/Data/SettingsData.dart';
import 'package:plarneit/IndentifierWidget.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/UserInput/Dialogs.dart';
import 'package:plarneit/UserMadeWidget/ID.dart';
import 'file:///C:/Users/Ruine/OneDrive/Desktop/Rui/Programming/CodingProjects/Unfinished/plarneit/lib/Data/WidgetData.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/main.dart';

abstract class UserMadeWidgetBase<T extends WidgetData> extends StatefulWidget {

  static final double widgetSize = 200.0;
  static final double widgetPadding = 10.0;
  static final double widgetInnerPadding = 30.0;
  static final double widgetBorderRadius = 30.0;

  final T widgetInformation;
  final WidgetId id;
  final WidgetContainerStatusController statusController;
  final Function widgetDeletionFunction;
  final JsonHandler jsonHandler;
  final String identifier;
  final String widgetIdPrefix;

  UserMadeWidgetBase(this.widgetInformation, this.statusController, this.id, this.widgetDeletionFunction, this.jsonHandler, this.identifier, this.widgetIdPrefix, {Key key}) : super(key: key) {
    initializeJson();
  }

  Map<String, String> returnJsonBase(WidgetData widgetInformation) {
    Map<String, String> result = {};
    result[WidgetData.titleTag] = widgetInformation.title;
    result[WidgetData.descriptionTag] = widgetInformation.description;
    return result;
  }

  void initializeJson() async {
    Map<String, dynamic> currentJsonContent = await this.jsonHandler.readFile();
    currentJsonContent.putIfAbsent(this.identifier, () => Map<String, dynamic>()); // creates widgets for that day if needed...
    Map<String, String> jsonBase = this.returnJsonBase(this.widgetInformation);
    jsonBase.addAll(this.updateAddition(this.widgetInformation));

    currentJsonContent[this.identifier].putIfAbsent(this.id.toString(), () => jsonBase); // this is not static programming (bruh)
    this.jsonHandler.writeToJson(currentJsonContent);
  }

  void updateJson(T newWidgetInformation) async {
    Map<String, dynamic> toUpdate = this.returnJsonBase(newWidgetInformation);
    toUpdate.addAll(this.updateAddition(newWidgetInformation));

    Map<String, dynamic> currentJsonContent = await this.jsonHandler.readFile();
    currentJsonContent[this.identifier][this.id.toString()] = toUpdate;
    this.jsonHandler.writeToJson(currentJsonContent);
  }

  Map updateAddition(T newWidgetInformation);

  void deleteJson() async {
    Map<String, dynamic> currentJsonContent = await this.jsonHandler.readFile();
    currentJsonContent[this.identifier].remove(this.id.toString());
    this.jsonHandler.writeToJson(currentJsonContent);
  }


}

abstract class UserMadeWidgetBaseState<T extends WidgetData> extends State<UserMadeWidgetBase<T>> {

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
      {Color noteColor,
        bool invertFontColor = false}) {

    double containerSize = UserMadeWidgetBase.widgetSize + UserMadeWidgetBase.widgetPadding;

    TextTheme theme = invertFontColor ? Theme.of(context).primaryTextTheme : Theme.of(context).accentTextTheme;
    List<Widget> children = [
      Text(this.title, style: theme.headline5),
      Text(this.description, style: theme.bodyText1)
    ];

    children.addAll(additionalChildren);

    return Container(
        height: containerSize,
        width: containerSize,
        child: Padding(
            padding: EdgeInsets.all(UserMadeWidgetBase.widgetPadding),
            child: Material(
                child: Ink(
                    width: UserMadeWidgetBase.widgetSize,
                    height: UserMadeWidgetBase.widgetSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(UserMadeWidgetBase.widgetBorderRadius)),
                      color: noteColor != null ? noteColor : PlarneitApp.DARK_GRAY,
                    ),
                    child: InkWell(
                        splashColor: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.all(Radius.circular(UserMadeWidgetBase.widgetBorderRadius)),
                        onTap: () async {
                          switch(this.widget.statusController.value) {
                            case ContainerStatus.EDITING:
                              this.editingFunction();
                              break;
                            case ContainerStatus.DELETING:
                              if ((await JsonHandlerWidget.of(context).settingsHandler.readFile())[SettingsData.deletionPopupTag]) {
                                CustomDialogs.showConfirmationDialog(context, "Are you sure you want to delete this widget?", () => this.widget.widgetDeletionFunction(this.widget));
                              } else {
                                this.widget.widgetDeletionFunction(this.widget);
                              }
                              break;
                            case ContainerStatus.STANDBY:
                              break;
                          }
                        },
                        child: Container(
                            width: UserMadeWidgetBase.widgetSize,
                            height: UserMadeWidgetBase.widgetSize,
                            child: ListView(
                                padding: EdgeInsets.all(UserMadeWidgetBase.widgetInnerPadding),
                                physics: ClampingScrollPhysics(),
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
