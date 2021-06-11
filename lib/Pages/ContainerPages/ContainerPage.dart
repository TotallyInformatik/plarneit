import 'package:flutter/material.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/Pages/ContainerPages/Navigationbar.dart';
import 'package:plarneit/WidgetContainers/WidgetContainer.dart';
import 'package:plarneit/main.dart';

abstract class ContainerPage<T> extends StatelessWidget {

  /// T -> Identifier type

  static final double listContainerInnerPadding = 20;

  final T identifier;
  final JsonHandlerCollection jsonCollection;
  final BuildContext context;

  ContainerPage(this.identifier, this.jsonCollection, this.context, {Key key}) : super(key: key);

  Future<Map> configureObjectsMap(JsonHandler jsonHandler, String identifier) async {
    Map<String, dynamic> jsonContents = await jsonHandler.readFile();
    Map<String, dynamic> objectsMap = jsonContents[identifier];

    if (objectsMap != null) {
      return objectsMap;
    } else {
      return null;
    }
  }

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