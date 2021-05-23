import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/utils/spacing.dart';
import 'utils/constants.dart';

import 'UrgencyTypes.dart';

class TimePickerController {
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
}

class TimePicker extends StatefulWidget {

  final String title;
  final TimePickerController controller;

  const TimePicker({Key key, this.title, this.controller}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TimePickerState();

}

class _TimePickerState extends State<TimePicker> {

  TimeOfDay _selectedTime = TimeOfDay(hour: 00, minute: 00);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: innerPadding),
      child: Row(

        children: [
          Text("${this.widget.title}:"),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () async {
                  TimeOfDay selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay(hour: this._selectedTime.hour, minute: this._selectedTime.minute));
                  this.widget.controller.selectedTime = selectedTime;
                  setState(() {
                    this._selectedTime = selectedTime;
                    print(this._selectedTime);
                  });
                },
                child: Container(
                    child: Text("${convertToString(this._selectedTime.hour)}:${convertToString(this._selectedTime.minute)}")
                )
              )
          )
        ],

      )
    );

  }

}

String formatTime(TimeOfDay time) {
  return "${convertToString(time.hour)}:${convertToString(time.minute)}";
}

String convertToString(int time) {
  String asString = time.toString();
  return asString.length > 1 ? asString : "0" + asString;
}