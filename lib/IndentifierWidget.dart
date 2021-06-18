import 'package:flutter/cupertino.dart';

///
/// For a detailed explanation of identifiers -> UserMadeWidgetBase.dart
/// InheritedWidget is used so that the identifier doesn't have to be passed into every class
///


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