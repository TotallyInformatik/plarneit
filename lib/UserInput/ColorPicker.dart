import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plarneit/UserInput/PickerBase.dart';
import '../Controllers.dart';

///
/// @author: Rui Zhang (TotallyInformatik)
///



/// ColorWidget
/// Round Widgets that represent Colors that can be clicked on
///

class ColorWidget extends StatelessWidget {

  final double size;
  final Color color;
  final void Function() onTapControllerFunction;
  static final double widgetPadding = 5;

  const ColorWidget(this.size, this.color, this.onTapControllerFunction, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ColorWidget.widgetPadding),
      child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(this.size / 2)),
          onTap: () {
            //this.toggleSelected();
            this.onTapControllerFunction();
          },
          child: Container(
            height: this.size,
            width: this.size,
            decoration: BoxDecoration(
              color: this.color,
              borderRadius: BorderRadius.all(Radius.circular(this.size / 2)),
            ),
          )
      ),
    );
  }

}

///
/// ColorPicker
/// Picker that is used to pick colors when creating notes
/// Uses ColorWidget to represent the options and passes a function that sets
/// the chosen color to the color of the ColorWidget
///

class ListColorPicker extends PickerBase<ColorPickerController> {
  final List<Color> colors;
  final double size;

  ListColorPicker(String title, ColorPickerController controller, this.colors, this.size) : super(title, controller);

  @override
  State<StatefulWidget> createState() => _ColorPickerState();

}

class _ColorPickerState extends State<ListColorPicker> {

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
                constraints: BoxConstraints.expand(
                  height: this.widget.size + ColorWidget.widgetPadding * 2,
                  width: MediaQuery.of(context).size.width * 0.35,
                ),
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

