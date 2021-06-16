import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/UserInput/ColorPicker.dart';
import 'file:///C:/Users/Ruine/OneDrive/Desktop/Rui/Programming/CodingProjects/Unfinished/plarneit/lib/Data/WidgetData.dart';
import '../Controllers.dart';
import 'TimePicker.dart';

class CustomDialogs {

  static final double innerPadding = 20;

  // base function
  static Future<T> showCustomDialog<T>(BuildContext context, String title, List<Widget> content, List<Widget> actions, {GlobalKey<FormState> formKey}) async {

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

  static String textFieldValidator(String value) {
    if (value == null || value.isEmpty) {
      return "required field";
    }
    return null;
  }

  static final _maxTextLength = 50;
  static Future<T> showEditDialog<T extends WidgetData>(BuildContext context, TextEditingController titleController, TextEditingController descriptionController, Function onSubmit, List<Widget> additionalInput, {String title, String description}) async {

    titleController.text = title;
    descriptionController.text = description;

    final _formKey = GlobalKey<FormState>();

    List<Widget> input = [
      TextFormField(
          style: Theme.of(context).primaryTextTheme.bodyText1,
          validator: textFieldValidator,
          maxLength: _maxTextLength,
          decoration: InputDecoration(
              hintText: "title"
          ),
          controller: titleController
      ),
      TextFormField(
          style: Theme.of(context).primaryTextTheme.bodyText1,
          validator: textFieldValidator,
          maxLength: _maxTextLength,
          decoration: InputDecoration(
              hintText: "description"
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

  static Future<TaskData> showTaskEditDialog(BuildContext context, {String title, String description, TimeOfDay starttime, TimeOfDay endtime}) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TimePickerController startTimeController = TimePickerController(initialTime: starttime);
    TimePickerController endTimeController = TimePickerController(initialTime: endtime);

    return showEditDialog<TaskData>(
        context,
        titleController,
        descriptionController,
            () => Navigator.of(context).pop(TaskData(titleController.text, descriptionController.text, startTimeController.value, endTimeController.value)),
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


  static final List<Color> noteColors = [
    Color.fromRGBO(255, 242, 171, 1),
    Color.fromRGBO(203, 241, 196, 1),
    Color.fromRGBO(255, 204, 229, 1),
    Color.fromRGBO(205, 233, 255, 1),
  ];
  static Future<NotesData> showNoteEditDialog(BuildContext context, {String title, String description, Color color}) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    ColorPickerController colorPickerController = ColorPickerController(noteColors, noteColors.contains(color) ? noteColors.indexOf(color) : 0);


    return showEditDialog<NotesData>(
        context,
        titleController,
        descriptionController,
            () => Navigator.of(context).pop(NotesData(titleController.text, descriptionController.text, colorPickerController.selectedColor)),
        [
          ColorPicker("color", colorPickerController, noteColors, 20.0)
        ],
        title: title,
        description: description
    );
  }

  static Future<DateTime> showYearPicker(BuildContext context) async {
    TextEditingController yearController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    return await showCustomDialog<DateTime>(
      context,
      "Choose year",
      [
        TextFormField(
          validator: textFieldValidator,
          controller: yearController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "yyyy"
          )
        )
      ],
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
              Navigator.of(context).pop(DateTime(int.parse(yearController.text)));
            }
          },
        )
      ],
      formKey: _formKey
    );
  }

}
