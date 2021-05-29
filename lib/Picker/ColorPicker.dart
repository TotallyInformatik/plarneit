import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/Picker/PickerBase.dart';
import 'package:plarneit/utils/conversion.dart';
import 'package:plarneit/utils/spacing.dart';
import '../Controllers.dart';
import '../utils/constants.dart';


class _ColorWidget extends StatefulWidget {

  final int size;
  final Color color;
  static final double widgetPadding = 5;
  static final Color selectedColor = Color.fromRGBO(61, 61, 61, 1);

  const _ColorWidget(this.size, this.color, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ColorWidgetState();

}

class _ColorWidgetState extends State<_ColorWidget> {

  bool _selected = false;

  void toggleSelected() {
    this._selected = !this._selected;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(_ColorWidget.widgetPadding),
      child: Container(
        decoration: BoxDecoration(
          color: this.widget.color,
          borderRadius: BorderRadius.all(Radius.circular(this.widget.size / 2)),
          border: this._selected ? Border.all(color: _ColorWidget.selectedColor) : null
        ),
      ),
    );
  }

}


class ColorPicker extends PickerBase<ColorPickerController> {
  ColorPicker(String title, ColorPickerController controller) : super(title, controller);

  @override
  State<StatefulWidget> createState() => _ColorPickerState();

}

class _ColorPickerState extends State<ColorPicker> {

  Color _selectedColor;
  _ColorWidget _selectedColorWidget;

  @override
  void initState() {
    super.initState();
    this._selectedColor = this.widget.controller.value;
  }

  @override
  Widget build(BuildContext context) {

    return PickerBase.returnStandardBuild(
      context,
      "Select note color: ",
      Row(

      )
    );

  }

}

