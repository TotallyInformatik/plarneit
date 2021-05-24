import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/utils/conversion.dart';
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
                  TimeOfDay selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: this._selectedTime.hour, minute: this._selectedTime.minute),
                      builder: (context, child) {
                        return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: ColorScheme.light(
                                // change the border color
                                primary: COLOR_INDIAN_RED,
                                // change the text color
                                onSurface: COLOR_INDIAN_RED,
                              ),
                              // button colors
                              buttonTheme: ButtonThemeData(
                                colorScheme: ColorScheme.light(
                                  primary: COLOR_INDIAN_RED,
                                ),
                              ),
                            ),
                            child: child
                        );
                      }
                  );
                  if (selectedTime.hour != null && selectedTime.minute != null) {
                    this.widget.controller.selectedTime = selectedTime;
                    setState(() {
                      this._selectedTime = selectedTime;
                      print(this._selectedTime);
                    });
                  }
                },
                child: Container(
                    child: Text(timeToString(this._selectedTime))
                )
              )
          )
        ],

      )
    );

  }

}