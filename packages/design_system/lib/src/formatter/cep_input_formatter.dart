import 'package:flutter/services.dart';

class CepInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // verifica o tamanho máximo do campo
    if (newValue.text.length > 9) return oldValue;

    final valorFinal = StringBuffer();
    int posicaoCursor = newValue.selection.end;

    for (int i = 0; i < newValue.text.length; i++) {
      if (i == 5 && !oldValue.text.contains(('-'))) {
        valorFinal.write('-');
        if (posicaoCursor > i) posicaoCursor++;
      }
      valorFinal.write(newValue.text[i]);
    }

    return TextEditingValue(
      text: valorFinal.toString(),
      selection: TextSelection.collapsed(offset: posicaoCursor),
    );
  }
}
