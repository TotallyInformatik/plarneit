import 'package:flutter/material.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/Pages/ContainerPages/Navigationbar.dart';
import 'package:plarneit/WidgetContainers/WidgetContainer.dart';
import 'package:plarneit/main.dart';

///
/// ContainerPage
/// An Abstract Widget Statelesswidget used for DayPage and LongtermPage as their
/// structure is very similar and both need similar attributes
///


abstract class ContainerPage extends StatelessWidget {

  static final double listContainerInnerPadding = 20;

  final DateTime identifier;
  final JsonHandlerCollection jsonCollection;
  final BuildContext context;

  ContainerPage(this.identifier, this.jsonCollection, this.context, {Key key}) : super(key: key);

  /// function used for getting all json data from according json files for Containers
  Future<Map> configureObjectsMap(JsonHandler jsonHandler, String identifier) async {
    Map<String, dynamic> jsonContents = await jsonHandler.readFile();
    Map<String, dynamic> objectsMap = jsonContents[identifier];

    if (objectsMap != null) {
      return objectsMap;
    } else {
      return null;
    }
  }

  /// functions that determine what happens when the navigationbar buttons are clicked
  void nextFunction(BuildContext context);
  void prevFunction(BuildContext context);
  void homeFunction(BuildContext context);
  void calendarFunction(BuildContext context);

  Widget returnStandardBuild(BuildContext context, List<WidgetContainer> containers, String title) {

    NavigationBar navigationBar = NavigationBar(this.homeFunction, this.prevFunction, this.nextFunction, this.calendarFunction);

    return Scaffold(
        bottomNavigationBar: navigationBar,
        body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                backgroundColor: PlarneitApp.DARK_GRAY,
                pinned: false,
                expandedHeight: 150.0,
                collapsedHeight: 80,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(left: ContainerPage.listContainerInnerPadding, bottom: 30),
                  title: Text(
                      title,
                      style: Theme.of(context).accentTextTheme.headline1,
                      textAlign: TextAlign.left
                  ),
                  background: Image(image: AssetImage("assets/images/forest1.jpg"), fit: BoxFit.cover),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(containers),
              )
            ]
        )
    );
  }

}