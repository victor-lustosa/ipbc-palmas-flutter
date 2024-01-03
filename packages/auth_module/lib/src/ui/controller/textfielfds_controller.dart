import 'package:flutter/material.dart';

class ControllerTextFields {
  static final List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());

  List<String> get textFieldValues {
    return controllers.map((controller) => controller.text).toList();
  }

  get textFieldsFilled {
    textFieldValues.every((value) => value.isNotEmpty);
  }
}
