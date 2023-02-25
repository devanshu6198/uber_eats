import 'package:flutter/widgets.dart';

extension $NumberExtension on num {
  String toFormattedCurrency([int? decimalPoint]) {
    if (this > 1000000000) {
      return "${(this / 1000000000).toStringAsFixed(decimalPoint ?? 2)} B";
    } else if (this > 1000000) {
      return "${(this / 1000000).toStringAsFixed(decimalPoint ?? 2)} M";
    } else if (this > 1000) {
      return "${(this / 1000).toStringAsFixed(decimalPoint ?? 4)} K";
    }
    return toStringAsFixed(decimalPoint ?? 8);
  }

  String toFormattedPrice([int? lengthAfterDecimal]) {
    int number = toInt();
    var floatingNumber = toDouble() - number;
    if (number > -1000 && number < 1000) {
      if (lengthAfterDecimal == 0) return number.toString();
      return "$number.${floatingNumber.toStringAsFixed(lengthAfterDecimal ?? 4).substring(2)}";
    }
    final String digits = number.abs().toString();
    final StringBuffer result = StringBuffer(number < 0 ? '-' : '');
    final int maxDigitIndex = digits.length - 1;
    for (int i = 0; i <= maxDigitIndex; i += 1) {
      result.write(digits[i]);
      if (i < maxDigitIndex && (maxDigitIndex - i) % 3 == 0) result.write(',');
    }
    if (lengthAfterDecimal == 0) return result.toString();
    return "$result.${floatingNumber.toStringAsFixed(lengthAfterDecimal ?? 4).substring(2)}";
  }

  double withTextScaleFactor(BuildContext context) {
    return this * MediaQuery.of(context).textScaleFactor;
  }
}
