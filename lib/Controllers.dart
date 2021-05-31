import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:plarneit/Picker/ColorPicker.dart';
import 'package:plarneit/utils/constants.dart';


class PickerController<T> {

  T _value;
  T get value { return this._value; }
  set value(T value) { this._value = value; }

  PickerController(T standardValue, {T initialValue}) {
    this._value = initialValue != null ? initialValue : standardValue;
  }

}


class EditingController extends PickerController<bool>{

  EditingController({bool initialStatus}) : super(false, initialValue: initialStatus);
  reverseIsEditing() { this._value = !this._value; }

}

class ColorPickerController extends PickerController<int> {
  List<Color> _colorWidgets;
  List<Color> get colorWidgets { return this._colorWidgets; }
  Color get selectedColor { return this._colorWidgets[this.value]; }


  ColorPickerController(List<Color> colorWidgets, int selectedIndex) : super(0, initialValue: selectedIndex) {
    this._colorWidgets = colorWidgets;
  }
}

class TimePickerController extends PickerController<TimeOfDay> {
  TimePickerController({TimeOfDay initialTime}) : super(TimeOfDay(hour: 00, minute: 00), initialValue: initialTime);
}