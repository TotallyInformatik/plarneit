import 'package:flutter/material.dart';
import 'package:plarneit/Data/SettingsData.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/Data/WidgetData.dart';
import 'package:plarneit/UserInput/Dialogs.dart';
import 'package:plarneit/UserMadeWidget/ID.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/main.dart';

///
/// UserMadeWidgetBase
/// since all user-created widgets have roughly the same structure,
/// a superclass is used to ensure unity in their design
///

abstract class UserMadeWidgetBase<T extends WidgetData> extends StatefulWidget {

  static final double widgetSize = 200.0;
  static final double widgetMargin = 10.0;
  static final double widgetInnerPadding = 20.0;
  static final double widgetBorderRadius = 30.0;

  final T widgetInformation;
  final WidgetId id;
  final WidgetContainerStatusController statusController; // the click function of widgets vary according to the status of its container, thats why the container is passed as an attribtue too
  final Function widgetDeletionFunction;
  final JsonHandler jsonHandler;
  final String identifier;
  ///
  /// The attributes identifier needs a little explanation:
  /// all json information of user made widgets are stored in an object in a json
  /// file. This json file has this structure:
  /// {
  ///   <identifier>: {
  ///     <widget-id> : {
  ///       <dynamic-widget-attributes>: <dynamic-values>
  ///       etc.
  ///     }
  ///     etc.
  ///   }
  /// }
  /// Every Widget belongs to a certain date (notes and tasks) or year (longtermnotes).
  /// This means that every widget must keep track of which date / year it belongs to
  /// when its properties are being written to a json file.
  /// The identifier is that key.
  ///
  UserMadeWidgetBase(this.widgetInformation, this.statusController, this.id, this.widgetDeletionFunction, this.jsonHandler, this.identifier, {Key key}) : super(key: key) {
    initializeJson();
  }

  ///
  /// the following functions (including and especially the abstract updateAddition function)
  /// are all used to write data into the according json files
  ///

  Map<String, String> returnJsonBase(WidgetData widgetInformation) {
    Map<String, String> result = {};
    result[WidgetData.titleTag] = widgetInformation.title;
    result[WidgetData.descriptionTag] = widgetInformation.description;
    return result;
  }

  /// is called when creating the widget and adds this widget to json file if
  /// it has just been added by user
  void initializeJson() async {
    Map<String, dynamic> currentJsonContent = await this.jsonHandler.readFile();
    currentJsonContent.putIfAbsent(this.identifier, () => Map<String, dynamic>()); // creates widgets for that day if needed...
    Map<String, String> jsonBase = this.returnJsonBase(this.widgetInformation);
    jsonBase.addAll(this.updateAddition(this.widgetInformation));

    currentJsonContent[this.identifier].putIfAbsent(this.id.toString(), () => jsonBase); // this is not static programming (bruh)
    this.jsonHandler.writeToJson(currentJsonContent);
  }

  /// updates json information
  void updateJson(T newWidgetInformation) async {
    Map<String, dynamic> toUpdate = this.returnJsonBase(newWidgetInformation);
    toUpdate.addAll(this.updateAddition(newWidgetInformation));

    Map<String, dynamic> currentJsonContent = await this.jsonHandler.readFile();
    currentJsonContent[this.identifier][this.id.toString()] = toUpdate;
    this.jsonHandler.writeToJson(currentJsonContent);
  }

  /// since every subclass (user created widget) has its own additional attributes
  /// this abstract function returns all the data that has to be added to the json map
  Map updateAddition(T newWidgetInformation);


  void deleteJson() async {
    Map<String, dynamic> currentJsonContent = await this.jsonHandler.readFile();
    dynamic identifierContents = currentJsonContent[this.identifier];
    identifierContents.remove(this.id.toString());

    if (identifierContents.length <= 0) {
      // this means that this date does not have any contents anymore
      currentJsonContent.remove(this.identifier);
    }

    this.jsonHandler.writeToJson(currentJsonContent);
  }


}

abstract class UserMadeWidgetBaseState<T extends WidgetData> extends State<UserMadeWidgetBase<T>> {

  String title;
  String description;

  static String titlePlaceholder = "title";
  static String descriptionPlaceholder = "description";

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

    double containerSize = UserMadeWidgetBase.widgetSize + UserMadeWidgetBase.widgetMargin;


    TextTheme theme = invertFontColor ? Theme.of(context).primaryTextTheme : Theme.of(context).accentTextTheme;
    TextStyle placeholderTheme = theme.bodyText1.apply(color: Color.fromRGBO(117, 117, 117, 1));
    List<Widget> children = [
      this.title == "" ? Text(titlePlaceholder, style: placeholderTheme) : Text(this.title, style: theme.headline5),
      this.description == ""?  Text(descriptionPlaceholder, style: placeholderTheme) : Text(this.description, style: theme.bodyText1)
    ];

    additionalChildren.addAll(children);

    return Container(
        height: containerSize,
        width: containerSize,
        child: Padding(
            padding: EdgeInsets.all(UserMadeWidgetBase.widgetMargin),
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
                            padding: EdgeInsets.all(UserMadeWidgetBase.widgetInnerPadding),
                            child: ListView(
                                physics: ClampingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                children: additionalChildren
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
