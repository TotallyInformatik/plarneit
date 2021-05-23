import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/utils/spacing.dart';
import 'TimePicker.dart';
import 'utils/constants.dart';

import 'UrgencyTypes.dart';

// base function
Future<Map> showCustomDialog(BuildContext context, String title, List<Widget> content, List<Widget> actions) async {

  ScrollController _scrollController = ScrollController();

  return showDialog<Map>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          elevation: 10,
          backgroundColor: Colors.white,
          child: Scrollbar(
            isAlwaysShown: true,
            controller: _scrollController,
            child: ListView(
              controller: _scrollController,
              children: [
                Container(
                  padding: EdgeInsets.all(innerPadding),
                  child: Column(
                      mainAxisSize: MainAxisSize.min, // doesn't do anything :(
                      children: [
                        Padding( // title
                            padding: EdgeInsets.only(top: innerPadding, bottom: innerPadding),
                            child: Text(title)
                        ),
                        Padding( // content
                            padding: EdgeInsets.all(innerPadding),
                            child: Column(
                                children: content
                            )
                        ),
                        Padding( // actions
                            padding: EdgeInsets.only(top: innerPadding),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: actions.map((action) => Expanded(child: action)).toList()
                            )
                        )
                      ]
                  ),
                )
              ],
            ),
          )
      );
    },
  );

}

Future<Map> showEditDialog(BuildContext context) async {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TimePickerController startTimeController = TimePickerController();
  TimePickerController endTimeController = TimePickerController();

  return await showCustomDialog(context,
    "Edit Content",
    [
      TextField(
          decoration: InputDecoration(
              hintText: "Please enter a title"
          ),
          controller: titleController
      ),
      TextField(
          decoration: InputDecoration(
              hintText: "Please enter a description"
          ),
          controller: descriptionController
      ),
      TimePicker(
        title: "start time:",
        controller: startTimeController
      ),
      TimePicker(
          title: "end time:",
          controller: endTimeController
      )
    ],
    [
      IconButton(
        icon: Icon(Icons.cancel_rounded),
        onPressed: () {
          Navigator.of(context).pop({});
        },
      ),
      IconButton(
        icon: Icon(Icons.done_rounded),
        onPressed: () {
          Navigator.of(context).pop({
            "title": titleController.text,
            "description": descriptionController.text,
            "start-time": startTimeController.selectedTime,
            "end-time": startTimeController.selectedTime
          });
        },
      )
    ]
  );
}


