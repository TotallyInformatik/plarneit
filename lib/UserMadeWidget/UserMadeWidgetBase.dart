import 'package:flutter/material.dart';
import 'package:plarneit/DayPageDate.dart';
import 'package:plarneit/EditingController.dart';
import 'package:plarneit/utils/constants.dart';

class UserMadeWidgetBase {
  static bool updateInJson(BuildContext context) {
    // TODO: implement

    DayPageDate.of(context); // use this
  }

  static Widget returnStandardUMWidgetStructure(BuildContext context, List<Widget> children, Function onTap, EditingController editingController) {
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
                        color: TASK_COLOR,
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
