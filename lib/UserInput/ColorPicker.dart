import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/UserInput/PickerBase.dart';
import 'package:plarneit/utils/conversion.dart';
import '../Controllers.dart';


class ColorWidget extends StatefulWidget {

  final double size;
  final Color color;
  final Function onTapControllerFunction;
  static final double widgetPadding = 5;
  static final Color selectedBorderColor = Color.fromRGBO(61, 61, 61, 1);

  const ColorWidget(this.size, this.color, this.onTapControllerFunction, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ColorWidgetState();

}

class _ColorWidgetState extends State<ColorWidget> {

  /*
  bool _selected = false;

  void toggleSelected() {
    this._selected = !this._selected;
  }
   */

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ColorWidget.widgetPadding),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(this.widget.size / 2)),
        onTap: () {
          //this.toggleSelected();
          this.widget.onTapControllerFunction();
        },
        child: Container(
          height: this.widget.size,
          width: this.widget.size,
          decoration: BoxDecoration(
            color: this.widget.color,
            borderRadius: BorderRadius.all(Radius.circular(this.widget.size / 2)),
            //border: this._selected ? Border.all(color: ColorWidget.selectedBorderColor) : null
          ),
        )
      ),
    );
  }

}


class ColorPicker extends PickerBase<ColorPickerController> {
  final List<Color> colors;
  final double size;

  ColorPicker(String title, ColorPickerController controller, this.colors, this.size) : super(title, controller);

  @override
  State<StatefulWidget> createState() => _ColorPickerState();

}

class _ColorPickerState extends State<ColorPicker> {

  Color _selectedColor;

  @override
  void initState() {
    super.initState();
    this._selectedColor = this.widget.controller.selectedColor;
  }

  @override
  Widget build(BuildContext context) {

    List<ColorWidget> colorChildren = [];
    for (int i = 0; i<this.widget.colors.length; i++) {
      Color setColor = new Color.fromRGBO(this.widget.colors[i].red, this.widget.colors[i].green, this.widget.colors[i].blue, this.widget.colors[i].opacity);
      colorChildren.add(ColorWidget(this.widget.size, setColor, () {
        this.setState(() {
          this._selectedColor = setColor;
        });
        this.widget.controller.value = i;
      }));
    }

    return this.widget.returnStandardBuild(
      context,
      Row(
          children: [
            Container(
              child: ColorWidget(this.widget.size + 10, this._selectedColor, () {}),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Container(
                height: this.widget.size + ColorWidget.widgetPadding * 2,
                width: 150,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: colorChildren
                ),
              )
            )
          ]
      )
    );

  }

}

