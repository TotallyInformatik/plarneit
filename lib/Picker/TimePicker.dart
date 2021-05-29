import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/Picker/PickerBase.dart';
import 'package:plarneit/utils/conversion.dart';
import 'package:plarneit/utils/spacing.dart';
import '../Controllers.dart';
import '../utils/constants.dart';

import '../UrgencyTypes.dart';

class TimePicker extends PickerBase<TimePickerController> {

  const TimePicker(String title, TimePickerController controller, {Key key}) : super(title, controller, key: key);

  @override
  State<StatefulWidget> createState() => _TimePickerState();

}

class _TimePickerState extends State<TimePicker> {

  TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    this._selectedTime = this.widget.controller.value;
  }

  @override
  Widget build(BuildContext context) {

    return PickerBase.returnStandardBuild(
      context,
      this.widget.title,
    InkWell(
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
            this.widget.controller.value = selectedTime;
            setState(() {
              this._selectedTime = selectedTime;
              print(this._selectedTime);
            });
          }
        },
        child: Container(
            child: Text(timeToString(this._selectedTime), style: Theme.of(context).primaryTextTheme.bodyText1))
        )
    );

  }

}