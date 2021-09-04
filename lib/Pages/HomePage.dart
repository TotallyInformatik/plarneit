import 'package:flutter/material.dart';
import 'package:plarneit/Firebase/firebase-test.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/Pages/ContainerPages/DayPage.dart';
import 'package:plarneit/Pages/ContainerPages/LongtermPage.dart';
import 'package:plarneit/Pages/SettingsPage.dart';
import 'package:plarneit/main.dart';
import 'package:plarneit/utils/classes/Pair.dart';


///
/// @author: Rui Zhang (TotallyInformatik)
///
/// HomePage
/// Not much to say here...
///

class HomePage extends StatelessWidget {

  static final Color buttonColor = Color.fromRGBO(245, 245, 245, 1);
  static final BorderRadius buttonRadius = BorderRadius.circular(20);

  static final double elementPadding = 50;

  static final double titleHeight = 0.2;

  Widget homePageButton(BuildContext context, IconData icon, String title, Function pressFunction) {
    return ElevatedButton.icon(
          onPressed: pressFunction,
          icon: Icon(icon, color: Colors.black),
          label: Text(title, style: Theme.of(context).primaryTextTheme.headline4),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          )
      );
  }

  void openPage(BuildContext context, Widget page) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => JsonHandlerWidget(
                jsonHandlers: PlarneitApp.jsonHandlerCollection,
                child: page
            )
        )
    );
  }

  String determineHomePageGreeting() {

    Map<Pair, String> timeToPartOfDay = {
      new Pair<int, int>(0, 11): "Morning",
      new Pair<int, int>(12, 18): "Afternoon",
      new Pair<int, int>(19, 23): "Evening"
    };
    TimeOfDay currentTime = TimeOfDay.now();

    for (MapEntry entry in timeToPartOfDay.entries) {

      Pair interval = entry.key;

      if (interval.e1 <= currentTime.hour && currentTime.hour <= interval.e2) {
        return entry.value;
      }

    }

    return "Morning";

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/homepageimage.jpg"),
            fit: BoxFit.cover
          )
        ),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Padding(
                    padding: EdgeInsets.only(top: 100, left: elementPadding),
                    child: Text("Good ${this.determineHomePageGreeting()}", style: Theme.of(context).primaryTextTheme.headline1, textAlign: TextAlign.left),
                ),
                Padding(
                  padding: EdgeInsets.only(left: elementPadding),
                  child: Text("What's on the agenda today?"),
                ),
                Padding(
                  padding: EdgeInsets.all(elementPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      homePageButton(context, Icons.assignment_rounded, "Short Term", () => openPage(context, DayPage(DateTime.now(), PlarneitApp.jsonHandlerCollection, context))),
                      homePageButton(context, Icons.assignment_rounded, "Long Term", () => openPage(context, LongtermPage(DateTime.now(), PlarneitApp.jsonHandlerCollection, context))),
                      homePageButton(context, Icons.settings, "Settings", () => openPage(context, SettingsPage(PlarneitApp.jsonHandlerCollection.settingsHandler.readFile()))),
                      ElevatedButton.icon(
                          onPressed: () async {
                            test();
                          },
                          icon: Icon(Icons.cloud, color: Colors.black),
                          label: Text("Cloud-Synchronization", style: Theme.of(context).primaryTextTheme.headline4),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
                          )
                      )
                    ],
                  )
              )
                ]
              )
            )
        )
    );

  }

}