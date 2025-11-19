import 'package:flutter/services.dart';

class PhoneInputFormatter extends TextInputFormatter {
  String phoneFormat(dynamic value) {
    String nums = value.replaceAll(RegExp(r'[\D]'), '');

    String phoneFormatted =
        nums.length > 2
            ? '${nums.isNotEmpty ? '(' : ''}${nums.substring(0, nums.length >= 2 ? 2 : null)}${nums.length > 1 ? ') ' : ''}${nums.length > 2 ? nums.substring(2, nums.length >= 7 ? 7 : null) + (nums.length > 7 ? '-${nums.substring(7, nums.length >= 11 ? 11 : null)}' : '') : ''}'
            : nums;
    return phoneFormatted;
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    return newValue.copyWith(
      text: phoneFormat(text),
      selection: TextSelection.collapsed(offset: phoneFormat(text).length),
    );
  }
}
