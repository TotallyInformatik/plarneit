
///
/// WidgetId
/// Classes that ensure that the ids of widgets in json files are always
/// in the same format
///

abstract class WidgetId {
  final int number;
  final String prefix;
  static final String connector = "-";

  WidgetId(this.number, this.prefix);

  String toString() {
    return "$prefix$connector$number";
  }

  static WidgetId fromString(String idString) {
    List<String> info = idString.split(connector);
    String prefix = info[0];
    int number = int.parse(info[1]);
    if (prefix == TaskId.setPrefix) {
      return TaskId(number);
    } else if (prefix == NoteId.setPrefix) {
      return NoteId(number);
    } else {
      throw Exception("parsing failed");
    }
  }

}

class TaskId extends WidgetId {
  static final String setPrefix = "task";

  TaskId(int number) : super(number, setPrefix);
}

/// NoteId is used by longterm notes as well as standard notes
class NoteId extends WidgetId {

  static final String setPrefix = "note";

  NoteId(int number) : super(number, setPrefix);
}