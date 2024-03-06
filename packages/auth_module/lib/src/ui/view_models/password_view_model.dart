import 'package:flutter/material.dart';

class PasswordViewModel extends ChangeNotifier {
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());

  List<FocusNode> get focusNodes => _focusNodes;

  List<TextEditingController> get controllers => _controllers;
}
