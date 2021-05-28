import 'package:flutter/cupertino.dart';

class DayPageDate extends InheritedWidget {

  final DateTime date;
  const DayPageDate({Key key, this.date, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(DayPageDate oldWidget) => date != oldWidget.date;

  static DayPageDate of(BuildContext context) {
    final DayPageDate result = context.dependOnInheritedWidgetOfExactType<DayPageDate>();
    assert(result != null, "No DayPageDate Widget in context");
    return result;
  }

}