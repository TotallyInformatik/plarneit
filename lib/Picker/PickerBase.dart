
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/utils/constants.dart';

abstract class PickerBase<T extends PickerController> extends StatefulWidget {

  final String title;
  final T controller;

  const PickerBase(this.title, this.controller, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState();

  Widget returnStandardBuild(
      BuildContext context,
      Widget display
      ) {

    return Padding(
        padding: EdgeInsets.only(top: innerPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(this.title, style: Theme.of(context).primaryTextTheme.headline6, textAlign: TextAlign.start,),
            display
          ],

        )
    );

  }

}