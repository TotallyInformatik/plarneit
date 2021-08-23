
import 'package:uuid/uuid.dart';

///
/// @author: Rui Zhang (TotallyInformatik)
///
/// WidgetId
/// Classes that ensure that the ids of widgets in json files are always
/// in the same format
///

abstract class WidgetId {
  final String number;
  final String prefix;

  static final String connector = "+";
  static final Uuid uuidGenerator = new Uuid();


  WidgetId(this.number, this.prefix);

  String toString() {
    return "$prefix$connector$number";
  }

  static WidgetId fromString(String idString) {
    List<String> info = idString.split(connector);
    String prefix = info[0];
    String uuid = info[1];
    if (prefix == TaskId.setPrefix) {
      return TaskId(uuid);
    } else if (prefix == NoteId.setPrefix) {
      return NoteId(uuid);
    } else {
      throw Exception("parsing failed");
    }
  }

}

class TaskId extends WidgetId {
  static final String setPrefix = "task";

  TaskId(String uuid) : super(uuid, setPrefix);

  static WidgetId newId() {
    return TaskId(WidgetId.uuidGenerator.v4());
  }
}

/// NoteId is used by longterm notes as well as standard notes
class NoteId extends WidgetId {

  static final String setPrefix = "note";

  NoteId(String uuid) : super(uuid, setPrefix);

  static WidgetId newId() {
    return NoteId(WidgetId.uuidGenerator.v4());
  }
}