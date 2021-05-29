
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/utils/constants.dart';

class PickerBase<T extends PickerController> extends StatefulWidget {

  final String title;
  final T controller;

  const PickerBase(this.title, this.controller, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError("Tried to create instance of base..., cringe");
  }

  static returnStandardBuild(
      BuildContext context,
      String title,
      Function onTap,
      Widget display,
      ) {

    return Padding(
        padding: EdgeInsets.only(top: innerPadding),
        child: Row(

          children: [
            Text(title, style: Theme.of(context).primaryTextTheme.headline6),
            Padding(
                padding: EdgeInsets.only(left: 10),
                child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: onTap,
                    child: Container(
                        child: display
                    )
                )
            )
          ],

        )
    );

  }

}