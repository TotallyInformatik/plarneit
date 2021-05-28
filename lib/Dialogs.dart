import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';
import 'file:///C:/Users/Ruine/OneDrive/Desktop/Rui/Programming/CodingProjects/Unfinished/plarneit/lib/UserMadeWidget/TaskWidget.dart';
import 'package:plarneit/utils/spacing.dart';
import 'TimePicker.dart';
import 'utils/constants.dart';

import 'UrgencyTypes.dart';

// base function
Future<dynamic> showCustomDialog(BuildContext context, String title, List<Widget> content, List<Widget> actions, {GlobalKey<FormState> formKey}) async {

  ScrollController _scrollController = ScrollController();

  return showDialog<dynamic>(
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
              shrinkWrap: true,
              controller: _scrollController,
              children: [
                Container(
                  padding: EdgeInsets.all(innerPadding),
                  child: Column(
                      mainAxisSize: MainAxisSize.min, // doesn't do anything :(
                      children: [
                        Padding( // title
                            padding: EdgeInsets.only(top: innerPadding, bottom: innerPadding),
                            child: Text(title, style: Theme.of(context).primaryTextTheme.headline4)
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
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
                              ),
                            ]
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

Future<TaskInformation> showEditDialog(BuildContext context, TextEditingController titleController, TextEditingController descriptionController, Function onSubmit, List<Widget> additionalInput, {String title, String description}) async {

  titleController.text = title;
  descriptionController.text = description;

  final _formKey = GlobalKey<FormState>();


  Function textFieldValidator = (String value) {
    if (value == null || value.isEmpty) {
      return "required field";
    }
    return null;
  };

  List<Widget> input = [
    TextFormField(
        validator: textFieldValidator,
        decoration: InputDecoration(
            hintText: "Please enter a title"
        ),
        controller: titleController
    ),
    TextFormField(
        validator: textFieldValidator,
        decoration: InputDecoration(
            hintText: "Please enter a description"
        ),
        controller: descriptionController
    ),
  ];
  input.addAll(additionalInput);

  return await showCustomDialog(context,
    "Edit Content",
    input,
    [
      IconButton(
        icon: Icon(Icons.cancel_rounded),
        onPressed: () {
          Navigator.of(context).pop(null);
        },
      ),
      IconButton(
        icon: Icon(Icons.done_rounded),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            onSubmit();
          }
        },
      )
    ],
    formKey: _formKey
  );
}



Future<TaskInformation> showTaskEditDialog(BuildContext context, {String title, String description, TimeOfDay starttime, TimeOfDay endtime}) {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TimePickerController startTimeController = TimePickerController();
  TimePickerController endTimeController = TimePickerController();

  return showEditDialog(
    context,
    titleController,
    descriptionController,
    () => Navigator.of(context).pop(TaskInformation(titleController.text, descriptionController.text, startTimeController.selectedTime, endTimeController.selectedTime)),
    [
      TimePicker(
        title: "start time:",
        controller: startTimeController,
        time: starttime,
      ),
      TimePicker(
        title: "end time:",
        controller: endTimeController,
        time: endtime,
      )
    ],
    title: title,
    description: description
  );
}
