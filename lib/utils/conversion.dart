import 'package:flutter/material.dart';

String enumToString(Object o) => o.toString().split('.').last;

T enumFromString<T>(String key, List<T> values) =>
    values.firstWhere((v) => key == enumToString(v), orElse: () => null);


String timeToString(TimeOfDay time) {
  return "${convertToString(time.hour)}:${convertToString(time.minute)}";
}

String convertToString(int time) {
  String asString = time.toString();
  return asString.length > 1 ? asString : "0" + asString;
}

TimeOfDay timeFromString(String timeString) {
  List<String> time = timeString.split(":");
  return TimeOfDay(hour: int.parse(time[0]), minute: int.parse(time[0]));
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