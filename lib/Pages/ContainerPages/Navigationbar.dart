import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plarneit/main.dart';

class NavigationBar<T> extends StatelessWidget {

  static final Color _appBarColor = Color.fromRGBO(220, 220, 220, 1);

  final FloatingActionButtonLocation location = FloatingActionButtonLocation.centerFloat;

  final Function homeFunction;
  final Function prevFunction;
  final Function nextFunction;
  final Function calendarFunction;

  NavigationBar(this.homeFunction, this.prevFunction, this.nextFunction, this.calendarFunction);


  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: _appBarColor,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                tooltip: "previous",
                icon: Icon(Icons.arrow_back_ios_rounded),
                onPressed: () => this.prevFunction(context),
              ),
              IconButton(
                tooltip: "back to current date",
                icon: Icon(Icons.home_rounded),
                onPressed: () => this.homeFunction(context),
              ),
              IconButton(
                tooltip: "next",
                icon: Icon(Icons.arrow_forward_ios_rounded),
                onPressed: () => this.nextFunction(context)
              )
            ]
          ),
          IconButton(
            icon: Icon(Icons.calendar_today_rounded),
            onPressed: () => this.calendarFunction(context)
          )
        ]
      )
    );
  }

  FloatingActionButton returnActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.home_rounded),
      onPressed: () {  },
    );
  }

}