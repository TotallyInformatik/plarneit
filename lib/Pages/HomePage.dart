import 'package:flutter/material.dart';
import 'package:plarneit/JsonHandler.dart';
import 'package:plarneit/Pages/ContainerPages/ContainerPage.dart';
import 'package:plarneit/Pages/ContainerPages/DayPage.dart';
import 'package:plarneit/Pages/ContainerPages/LongtermPage.dart';
import 'package:plarneit/Pages/ContainerPages/Navigationbar.dart';
import 'package:plarneit/main.dart';

class HomePage extends StatelessWidget {

  static final Color buttonColor = Color.fromRGBO(245, 245, 245, 1);
  static final BorderRadius buttonRadius = BorderRadius.circular(20);

  static final double elementPadding = 50;

  static final double titleHeight = 0.2;

  Widget homePageButton(BuildContext context, IconData icon, String title, Function pressFunction) {
    return ElevatedButton.icon(
          onPressed: pressFunction,
          icon: Icon(icon, color: Colors.black),
          label: Text(title, style: Theme.of(context).primaryTextTheme.headline3),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
            /*shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: buttonRadius
                )
            )
             */
          )
      );
  }

  void openPlanningPage(BuildContext context, ContainerPage page) {
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
                    child: Text("Plarneit", style: Theme.of(context).primaryTextTheme.headline1, textAlign: TextAlign.left)
                ),
                Padding(
                  padding: EdgeInsets.all(elementPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [ // TODO: remove buttons that will have to stay unimplemented due to deadline (school project)
                      homePageButton(context, Icons.assignment_rounded, "Shortterm Planning", () => openPlanningPage(context, DayPage(DateTime.now(), PlarneitApp.jsonHandlerCollection, context))),
                      homePageButton(context, Icons.assignment_rounded, "Longterm Planning", () => openPlanningPage(context, LongtermPage(DateTime.now(), PlarneitApp.jsonHandlerCollection, context))),
                      homePageButton(context, Icons.settings, "Settings", () {}),
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