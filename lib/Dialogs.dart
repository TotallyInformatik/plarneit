import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/utils/spacing.dart';
import 'utils/constants.dart';

import 'UrgencyTypes.dart';

// base
Future<List<String>> showCustomDialog(BuildContext context, String title, List<Widget> content, List<Widget> actions) async {

  return showDialog<List<String>>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          elevation: 10,
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.all(innerPadding),
            child: Column(
                mainAxisSize: MainAxisSize.min,
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
      );
    },
  );

}

Future<List<String>> showEditDialog(BuildContext context) async {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


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
      )
    ],
    [
      IconButton(
        icon: Icon(Icons.cancel_rounded),
        onPressed: () {
          Navigator.of(context).pop(["None"]);
        },
      ),
      IconButton(
        icon: Icon(Icons.done_rounded),
        onPressed: () {
          Navigator.of(context).pop([titleController.text, descriptionController.text]);
        },
      )
    ]
  );
}

/*
showDialog<List<String>>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          elevation: 10,
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.all(innerPadding),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: innerPadding, bottom: innerPadding),
                      child: Text("Edit Content")
                  ),
                  Padding(
                      padding: EdgeInsets.all(innerPadding),
                      child: Column(

                          children: [
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
                            )
                          ]
                      )
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: innerPadding),
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                child: IconButton(
                                  icon: Icon(Icons.cancel_rounded),
                                  onPressed: () {
                                    Navigator.of(context).pop(["None"]);
                                  },
                                )
                            ),
                            Expanded(
                                child: IconButton(
                                  icon: Icon(Icons.done_rounded),
                                  onPressed: () {
                                    Navigator.of(context).pop([titleController.text, descriptionController.text]);
                                  },
                                )
                            )
                          ]
                      )
                  )
                ]
            ),
          )
      );
    },
  );
 */