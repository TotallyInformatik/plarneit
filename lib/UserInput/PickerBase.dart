import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/UserInput/Dialogs.dart';

///
/// @author: Rui Zhang (TotallyInformatik)#
///
/// PickerBase:
/// An Abstract widget for all custom pickers -> DatePicker, ColorPicker
/// Every Picker uses a controller so that the chosen value can be used by dialogs etc.
/// T is the controller type that is used.
///

abstract class PickerBase<T extends PickerController> extends StatefulWidget {

  static final innerPadding = CustomDialogs.innerPadding;

  final String title;
  final T controller;

  const PickerBase(this.title, this.controller, {Key key}) : super(key: key);

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