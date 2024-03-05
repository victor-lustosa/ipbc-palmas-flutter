import 'package:flutter/material.dart';

class PasswordViewModel extends ChangeNotifier {
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());

  List<FocusNode> get focusNodes => _focusNodes;

  List<TextEditingController> get controllers => _controllers;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController resetPasswordController = TextEditingController();

  String _passwordControllerValue = '';
  String _resetPasswordController = '';
  String _confirmPasswordControllerValue = '';

  String get passwordControllerValue => _passwordControllerValue;
  String get resetPasswordControllerValue => _resetPasswordController;
  String get confirmPasswordControllerValue => _confirmPasswordControllerValue;

  void setValuePass(value) {
    _passwordControllerValue = passwordController.text;
  }

  void setValueEmail(value) {
    _resetPasswordController = resetPasswordController.text;
  }

  void setValueConfirmPass(value) {
    _confirmPasswordControllerValue = confirmPasswordController.text;
  }
}
