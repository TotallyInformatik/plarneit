import 'package:flutter/src/widgets/framework.dart';
import 'package:plarneit/Controllers.dart';
import 'package:plarneit/UserInput/PickerBase.dart';

class YearPicker extends PickerBase<YearPickerController> {
  YearPicker(String title, PickerController controller, {Key key}) : super(title, controller, key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}