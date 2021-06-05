import 'package:flutter/material.dart';

extension timeX on TimeOfDay {
  String xToString() {
    return "${_convertToString(this.hour)}:${_convertToString(this.minute)}";
  }

  static String _convertToString(int time) { // only helper function!!!
    String asString = time.toString();
    return asString.length > 1 ? asString : "0" + asString;
  }

  static TimeOfDay fromString(String timeString) {
    List<String> time = timeString.split(":");
    return TimeOfDay(hour: int.parse(time[0]), minute: int.parse(time[0]));
  }

}

extension colorX on Color {
  String xToString() {
    return "#${this.red.toRadixString(16).padLeft(2, "0")}${this.green.toRadixString(16).padLeft(2, "0")}${this.blue.toRadixString(16).padLeft(2, "0")}";
  }

  static Color fromString(String hexString) {
    String withoutTag = hexString.substring(1);
    int red = int.parse("0x${withoutTag.substring(0, 2)}");
    int green = int.parse("0x${withoutTag.substring(2, 4)}");
    int blue = int.parse("0x${withoutTag.substring(4)}");
    return Color.fromARGB(0xFF, red, green, blue);
  }
}

extension dateX on DateTime {
  String xToString({bool yearOnly = false}) {
    if (!yearOnly) {
      return "${this.day}-${this.month}-${this.year}";
    } else {
      return "${this.year}";
    }
  }

  DateTime fromString(String dateString) {
    throw UnimplementedError();
  }

}

class Conversion {

  // enum conversion

  static String enumToString(Object o) => o.toString().split('.').last;

  static T enumFromString<T>(String key, List<T> values) =>
      values.firstWhere((v) => key == enumToString(v), orElse: () => null);


  // color conversion

}


const Map<int, String> MONTH_TO_STRING = {
  1: "January",
  2: "February",
  3: "March",
  4: "April",
  5: "May",
  6: "June",
  7: "Juli",
  8: "August",
  9: "September",
  10: "October",
  11: "November",
  12: "December"
};

String dateToText(DateTime dateTime) { // not for json!
  String suffix;
  switch (dateTime.day) {
    case 1:
      suffix = "st";
      break;
    case 2:
      suffix = "nd";
      break;
    case 3:
      suffix = "rd";
      break;
    default:
      suffix = "th";
      break;
  }

  return "${dateTime.day}${suffix} ${MONTH_TO_STRING[dateTime.month]}";
}