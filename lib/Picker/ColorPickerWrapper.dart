
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/Picker/PickerBase.dart';

class ColorPickerWrapper extends PickerBase<ColorPickerController> {
 const  ColorPickerWrapper(String title, ColorPickerController controller, {Key key}) : super(title, controller, key: key);


 @override
 State<StatefulWidget> createState() => _ColorPickerWrapperState();

}

class _ColorPickerWrapperState extends State<ColorPickerWrapper> {

  Color _selectedColor;

  @override
  void initState() {
    super.initState();
    this._selectedColor = this.widget.controller.value;
  }

  @override
  Widget build(BuildContext context) {

    return PickerBase.returnStandardBuild(
        context,
        this.widget.title,
        () async {
          Color newColor = await showDialog<Color> (
            context: context.,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(this.widget.title),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: this._selectedColor,
                      onColorChanged: (Color value) {
                        this.widget.controller.value = value;
                      },
                    )
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop()
                      },
                      icon: Icon(Icons.done_rounded),
                    )
                  ],
                );
              }
          );
        },
        Container(
          decoration: BoxDecoration(
            color: this._selectedColor
          ),
        )
    );

  }

}
