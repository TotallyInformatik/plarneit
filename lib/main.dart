import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:plarneit/JsonHandler.dart';

import 'DayPage.dart';

void main() {

  runApp(PlarneitApp());
}

class PlarneitApp extends StatelessWidget {
  // This widget is the root of your application.

  static final COLOR_WHITE = Color.fromRGBO(255, 255, 255, 1);
  static final COLOR_WHITESMOKE = Color.fromRGBO(245, 245, 245, 1);
  static final COLOR_INDIAN_RED = Color.fromRGBO(186, 71, 63, 1);
  static final COLOR_INDIAN_RED_LIGHT = Color.fromRGBO(212, 97, 97, 1);
  static final FONT_COLOR = Color.fromRGBO(10, 10, 10, 1);
  static final WHITE_FONT_COLOR = Colors.white;
  static final TASK_COLOR = Color.fromRGBO(40, 40, 40, 1);
  static final STANDARD_NOTE_COLOR = Color.fromRGBO(245, 235, 125, 1);


  static final TextTheme TEXT_THEME_DEFAULT = TextTheme(
      headline1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 26),
      headline2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 22),
      headline3: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 20),
      headline4: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 16),
      headline5: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 14),
      headline6: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 12),
      bodyText1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 14, height: 1.5),
      bodyText2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 16, height: 1.5), // change this if needed
      subtitle1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 12),
      subtitle2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 14) // change if needed
  );

  static final TextTheme TEXT_THEME_SMALL = TextTheme( // for smaller devices
      headline1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 22),
      headline2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 20),
      headline3: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 18),
      headline4: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 14),
      headline5: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 12),
      headline6: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 10),
      bodyText1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 12, height: 1.5),
      bodyText2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 14, height: 1.5), // change this if needed
      subtitle1: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 10),
      subtitle2: TextStyle(color: FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 12) // change if needed
  );

  static final TextTheme TEXT_THEME_DEFAULT_WHITE = TextTheme(
      headline1: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 26),
      headline2: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 22),
      headline3: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 20),
      headline4: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 16),
      headline5: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 14),
      headline6: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 12),
      bodyText1: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 14, height: 1.5),
      bodyText2: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 14, height: 1.5), // change this if needed
      subtitle1: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 12),
      subtitle2: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 12) // change if needed
  );

  static final TextTheme TEXT_THEME_SMALL_WHITE = TextTheme(
      headline1: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 22),
      headline2: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 20),
      headline3: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 18),
      headline4: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 14),
      headline5: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 12),
      headline6: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w700, fontSize: 10),
      bodyText1: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 12, height: 1.5),
      bodyText2: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w500, fontSize: 14, height: 1.5), // change this if needed
      subtitle1: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 10),
      subtitle2: TextStyle(color: WHITE_FONT_COLOR, fontWeight: FontWeight.w400, fontSize: 12) // change if needed
  );

  static final String taskStorage = "tasks.json";
  static final String noteStorage = "notes.json";
  static final String longtermGoalsStorage = "longterm-goals.json";
  static final JsonHandlerCollection jsonHandlerCollection = new JsonHandlerCollection(
      JsonHandler(taskStorage),
      JsonHandler(noteStorage),
      JsonHandler(longtermGoalsStorage)
  );

  void _resetJson() {
    jsonHandlerCollection.noteHandler.writeToJson({});
    jsonHandlerCollection.taskHandler.writeToJson({});
    jsonHandlerCollection.longtermGoalsHandler.writeToJson({});
  }

  void deleteOutdated() {

  }

  void displayJsonContents() async {
    print(await jsonHandlerCollection.taskHandler.readFile());
    print(await jsonHandlerCollection.noteHandler.readFile());
    print(await jsonHandlerCollection.longtermGoalsHandler.readFile());
  }

  @override
  Widget build(BuildContext context) {
    displayJsonContents();
    deleteOutdated();

    double screenWidth = window.physicalSize.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'plarneit',
      theme: ThemeData(
        primaryColor: COLOR_WHITE,
        accentColor: COLOR_WHITESMOKE,
        accentTextTheme: screenWidth > 500 ? TEXT_THEME_DEFAULT_WHITE : TEXT_THEME_SMALL_WHITE,
        primaryTextTheme: screenWidth > 500 ? TEXT_THEME_DEFAULT : TEXT_THEME_SMALL,
        fontFamily: "Montserrat"
      ),
      home: JsonHandlerWidget(
        jsonHandlers: jsonHandlerCollection,
        child: DayPage(DateTime.now())
      ),
    );
  }
}

/*
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/