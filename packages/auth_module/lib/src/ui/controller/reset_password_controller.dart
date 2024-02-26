import 'package:flutter/material.dart';

class ResetPasswordController {
  TextEditingController resetPasswordController = TextEditingController();

  String _resetPasswordController = '';

  String get resetPasswordControllerValue => _resetPasswordController;

  void setValueEmail(value) {
    _resetPasswordController = resetPasswordController.text;
  }
}
