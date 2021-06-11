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

class NoteId extends WidgetId { // wird sowohl von Notes als auch von LongtermNotes benutzt

  static final String setPrefix = "note";

  NoteId(int number) : super(number, setPrefix);
}