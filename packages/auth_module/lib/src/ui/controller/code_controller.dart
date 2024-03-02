import 'package:flutter/material.dart';

class CodeController extends ChangeNotifier {
  final List<int> code = [1, 2, 3, 4, 5, 8]; // Code Mockado;
  String textingCode = '';

  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());

  get focusNodes => _focusNodes;
}
