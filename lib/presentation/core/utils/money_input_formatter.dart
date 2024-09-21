import 'package:flutter/services.dart';

class MoneyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final RegExp regExp = RegExp(r'^\d{0,10}([.,]\d{0,2})?$');

    TextEditingValue result =
        regExp.hasMatch(newValue.text) ? newValue : oldValue;
    result = result.copyWith(text: result.text.replaceAll(',', '.'));
    if (result.text.startsWith('.')) {
      final newSelection = result.selection.copyWith(
          extentOffset: result.selection.end + 1,
          baseOffset: result.selection.end + 1);
      return result.copyWith(text: "0${result.text}", selection: newSelection);
    }
    return result;
  }
}