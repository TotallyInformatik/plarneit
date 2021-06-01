import 'package:flutter/cupertino.dart';

class Identifier<T> extends InheritedWidget {

  final T identifier;
  const Identifier({Key key, @required this.identifier, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(Identifier oldWidget) => identifier != oldWidget.identifier;

  static Identifier of(BuildContext context) {
    final Identifier result = context.dependOnInheritedWidgetOfExactType<Identifier>();
    assert(result != null, "No Identifier Widget in context");
    return result;
  }

}