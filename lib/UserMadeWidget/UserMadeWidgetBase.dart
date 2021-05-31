import 'package:flutter/material.dart';
import 'package:plarneit/DayPageDate.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';
import 'package:plarneit/utils/constants.dart';


abstract class UserMadeWidgetBase extends StatefulWidget {

  final WidgetInformation widgetInformation;
  final int id;
  final WidgetContainerStatusController statusController;
  final Function widgetDeletionFunction;

  const UserMadeWidgetBase(this.widgetInformation, this.statusController, this.id, this.widgetDeletionFunction, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState();

  static bool updateInJson(BuildContext context) {
    // TODO: implement

    DayPageDate.of(context); // use this
  }
}

abstract class UserMadeWidgetBaseState<T extends WidgetInformation> extends State<UserMadeWidgetBase> {

  Widget returnStandardBuild(
      BuildContext context,
      List<Widget> children,
      Function editingFunction,
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
                        onTap: () {
                          switch(this.widget.statusController.value) {
                            case ContainerStatus.EDITING:
                              editingFunction();
                              break;
                            case ContainerStatus.DELETING:
                              this.widget.widgetDeletionFunction(this.widget);
                              break;
                            case ContainerStatus.STANDBY:
                              break;
                          }
                        },
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

  void updateAttributes(T widgetInformation);

}
