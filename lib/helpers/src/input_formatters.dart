import 'package:flutter/services.dart';

class NumberInputFormatter extends TextInputFormatter {
  final int length;
  final bool allowFloating;

  NumberInputFormatter({this.length = 255, this.allowFloating = false});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > length) return oldValue;
    if (newValue.text.length > oldValue.text.length) {
      if (allowFloating) {
        return double.tryParse(newValue.text) != null ? newValue : oldValue;
      } else {
        return int.tryParse(newValue.text) != null ? newValue : oldValue;
      }
    } else {
      return newValue;
    }
  }
}

class MobileNumberInputFormatter extends TextInputFormatter {
  MobileNumberInputFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.replaceAll(" ", "").length > 11) return oldValue;
    if (newValue.text.length > oldValue.text.length) {
      if (int.tryParse(newValue.text.replaceAll(" ", "")) == null) {
        return oldValue;
      }
      var newText = newValue.text.replaceAll(" ", "");
      StringBuffer buffer = StringBuffer();
      for (int index = 0; index < newText.length; index++) {
        buffer.write(newText[index]);
        if (index == 2 || index == 5) buffer.write(" ");
      }
      return TextEditingValue(text: buffer.toString(), selection: TextSelection.collapsed(offset: buffer.length));
    } else {
      var newText = newValue.text.trim();
      return newValue.copyWith(text: newText.trim(), selection: TextSelection.collapsed(offset: newText.length));
    }
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text.replaceAll("/", '');
    if (newText.isNotEmpty && int.tryParse(newText) == null) {
      return oldValue;
    } else if (newValue.text.length > 7) {
      return oldValue;
    } else if (newValue.text.length < oldValue.text.length) {
      return newValue;
    } else if (newValue.text.length < 2) {
      return newValue;
    } else if (newValue.text.length == 2) {
      return int.parse(newValue.text) > 12 ? oldValue : newValue;
    }

    var string = _getFormattedCardMonth(newText, false);
    return newValue.copyWith(text: string, selection: TextSelection.collapsed(offset: string.length));
  }

  String _getFormattedCardMonth(String cardMonth, [bool padZero = true]) {
    if (cardMonth.isEmpty) return "00/0000";
    var text = padZero ? cardMonth.replaceAll("/", '').padRight(6, "0") : cardMonth;
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1) buffer.write('/');
    }
    return buffer.toString().trim();
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text.replaceAll(" ", '').trim();
    if (newValue.text.length < oldValue.text.length) {
      var text = newValue.text.trim();
      return newValue.copyWith(text: text, selection: TextSelection.collapsed(offset: text.length));
    } else if (newText.isNotEmpty && int.tryParse(newValue.text.split(" ").last) == null) {
      return oldValue;
    } else if (newValue.text.length < 4) {
      return newValue;
    } else if (newText.length > 20) {
      return oldValue;
    }
    var string = _getFormattedCardNumber(newText, false);
    return newValue.copyWith(text: string, selection: TextSelection.collapsed(offset: string.length));
  }

  String _getFormattedCardNumber(String cardNumber, [bool padZero = true]) {
    if (cardNumber.isEmpty) return "0000  0000  0000  0000";
    var text = padZero ? cardNumber.replaceAll(" ", '').padRight(16, "0") : cardNumber;
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0) buffer.write("  ");
    }
    return buffer.toString().trim();
  }
}
