import 'dart:ui';

import 'package:flutter/material.dart';


class PickerController<T> {

  T _value;
  T get value { return this._value; }
  set value(T value) { this._value = value; }

  PickerController(T standardValue, {T initialValue}) {
    this._value = initialValue != null ? initialValue : standardValue;
  }

}


enum ContainerStatus {
  EDITING,
  DELETING,
  STANDBY
}

class WidgetContainerStatusController extends PickerController<ContainerStatus> {

  WidgetContainerStatusController({ContainerStatus initialStatus}) : super(ContainerStatus.STANDBY, initialValue: initialStatus);

  toggleStatus(ContainerStatus status) {
    if (this._value == status) {
      this._value = ContainerStatus.STANDBY;
    } else {
      this._value = status;
    }
  }

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

class YearPickerController extends PickerController<DateTime> {
  void setYear(int year) { this._value = DateTime(year); }

  YearPickerController({DateTime initialYear}) : super(DateTime.now(), initialValue: initialYear);
}