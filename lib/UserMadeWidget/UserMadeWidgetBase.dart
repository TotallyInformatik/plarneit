import 'package:flutter/material.dart';
import 'package:plarneit/DayPageDate.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';
import 'package:plarneit/utils/constants.dart';


abstract class UserMadeWidgetBase extends StatefulWidget {

  final WidgetInformation widgetInformation;
  final int id;
  final EditingController eController;


  const UserMadeWidgetBase(this.widgetInformation, this.eController, this.id, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState();

  static bool updateInJson(BuildContext context) {
    // TODO: implement

    DayPageDate.of(context); // use this
  }

  Widget returnStandardBuild(
      BuildContext context,
      List<Widget> children,
      Function onTap,
      {Color noteColor}) {
    double containerSize = widgetSize + widgetPadding;

    return Container(
          height: containerSize,
          width: containerSize,
          child: Padding(
              padding: EdgeInsets.all(widgetPadding),
              child: Material(
                  child: Ink(
                      width: widgetSize,
                      height: widgetSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(widgetBorderRadius)),
                        color: noteColor != null ? noteColor : TASK_COLOR,
                      ),
                      child: InkWell(
                          splashColor: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.all(Radius.circular(widgetBorderRadius)),
                          onTap: onTap,
                          child: Container(
                              width: widgetSize,
                              height: widgetSize,
                              child: ListView(
                                  padding: EdgeInsets.all(widgetInnerPadding),
                                  scrollDirection: Axis.vertical,
                                  children: children
                              )
                          )
                      )
                  )
              )

          )
      );

  }
}
