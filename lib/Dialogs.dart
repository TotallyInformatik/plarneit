import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/Picker/ColorPicker.dart';
import 'package:plarneit/UserMadeWidget/WidgetInformation.dart';
import 'Controllers.dart';
import 'package:plarneit/utils/spacing.dart';
import 'Picker/TimePicker.dart';
import 'utils/constants.dart';

import 'UrgencyTypes.dart';

// base function
Future<T> showCustomDialog<T>(BuildContext context, String title, List<Widget> content, List<Widget> actions, {GlobalKey<FormState> formKey}) async {

  ScrollController _scrollController = ScrollController();

  return showDialog<T>(
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

Future<T> showEditDialog<T extends WidgetInformation>(BuildContext context, TextEditingController titleController, TextEditingController descriptionController, Function onSubmit, List<Widget> additionalInput, {String title, String description}) async {

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

  return await showCustomDialog<T>(context,
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
  TimePickerController startTimeController = TimePickerController(initialTime: starttime);
  TimePickerController endTimeController = TimePickerController(initialTime: endtime);

  return showEditDialog<TaskInformation>(
    context,
    titleController,
    descriptionController,
    () => Navigator.of(context).pop(TaskInformation(titleController.text, descriptionController.text, startTimeController.value, endTimeController.value)),
    [
      TimePicker(
        "start time:",
        startTimeController
      ),
      TimePicker(
        "end time:",
        endTimeController
      )
    ],
    title: title,
    description: description
  );
}

Future<NotesInformation> showNoteEditDialog(BuildContext context, {String title, String description, Color color}) {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // TODO: add better colors
  List<Color> colors = [
    Colors.blue,
    Colors.black,
    Colors.yellow,
    Colors.red
  ];
  ColorPickerController colorPickerController = ColorPickerController(colors, colors.contains(color) ? colors.indexOf(color) : 0);

  return showEditDialog<NotesInformation>(
      context,
      titleController,
      descriptionController,
          () => Navigator.of(context).pop(NotesInformation(titleController.text, descriptionController.text, colorPickerController.selectedColor)),
      [
        ColorPicker("Select color", colorPickerController, colors, 25.0)
      ],
      title: title,
      description: description
  );
}

