import 'package:flutter/material.dart';

class PassFieldController {
  TextEditingController passwordController = TextEditingController();

  String _passwordControllerValue = '';

  String get passwordControllerValue => _passwordControllerValue;

  void setValuePass(value) {
    _passwordControllerValue = passwordController.text;
  }
}
