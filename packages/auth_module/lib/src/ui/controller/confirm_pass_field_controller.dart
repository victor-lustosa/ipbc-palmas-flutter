import 'package:flutter/material.dart';

class ConfirmPassFieldController {
  TextEditingController confirmPasswordController = TextEditingController();

  String _confirmPasswordControllerValue = '';

  String get confirmPasswordControllerValue => _confirmPasswordControllerValue;

  void setValuePass(value) {
    _confirmPasswordControllerValue = confirmPasswordController.text;
  }
}
