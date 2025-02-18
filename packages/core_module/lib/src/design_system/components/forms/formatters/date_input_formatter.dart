import 'package:flutter/services.dart';

/// Formata o valor do campo com a mascara de data `01/01/1900`.
class DataInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (text.length > 8) text = text.substring(0, 8);

    var buffer = StringBuffer();
    var selectionIndex = text.length;

    for (var i = 0; i < text.length; i++) {
      if (i == 2 || i == 4) {
        buffer.write('/');
        selectionIndex++;
      }
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
