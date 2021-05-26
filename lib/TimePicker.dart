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
  final TimeOfDay time;

  const TimePicker({Key key, this.title, this.controller, this.time}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TimePickerState();

}

class _TimePickerState extends State<TimePicker> {

  TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    this._selectedTime = this.widget.time != null ? this.widget.time : TimeOfDay(hour: 00, minute: 00);
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: innerPadding),
      child: Row(

        children: [
          Text("${this.widget.title}", style: Theme.of(context).primaryTextTheme.headline6),
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
                                primary: FONT_COLOR,
                                // change the text color
                                onSurface: FONT_COLOR,
                              ),
                              // button colors
                              buttonTheme: ButtonThemeData(
                                colorScheme: ColorScheme.light(
                                  primary: FONT_COLOR,
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
                    child: Text(timeToString(this._selectedTime), style: Theme.of(context).primaryTextTheme.bodyText1)
                )
              )
          )
        ],

      )
    );

  }

}