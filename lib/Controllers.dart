import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:plarneit/utils/constants.dart';


class PickerController<T> {

  T _value;
  get value { return this._value; }
  set value(T value) { this._value = value; }

  PickerController(T standardValue, {T initialValue}) {
    this._value = initialValue != null ? initialValue : standardValue;
  }

}


class EditingController extends PickerController<bool>{ // change this

  EditingController({bool initialStatus}) : super(false, initialValue: initialStatus);
  reverseIsEditing() { this._value = !this._value; }

}

class ColorPickerController extends PickerController<Color> {
  ColorPickerController({Color initialColor}) : super(STANDARD_NOTE_COLOR, initialValue: initialColor);
}

class TimePickerController extends PickerController<TimeOfDay> {
  TimePickerController({TimeOfDay initialTime}) : super(TimeOfDay(hour: 00, minute: 00), initialValue: initialTime);
}