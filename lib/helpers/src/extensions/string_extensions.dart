import 'package:intl/intl.dart';

extension $StringExtension on String {
  DateTime parseUtcDateTime([String format = "yyyy-MM-dd HH:mm:ss"]) {
    var time = DateFormat(format).parseUTC(replaceAll("T", " ").replaceAll("Z", " "));
    return time;
  }

  DateTime parseLocalDateTime([String format = "yyyy-MM-dd HH:mm:ss"]) {
    var time = DateFormat(format).parse(replaceAll("T", " ").replaceAll("Z", " "));
    return time;
  }

  String toFormattedPrice([int? lengthAfterDecimal]) {
    int number = double.parse(this).toInt();
    var floatingNumber = double.parse(this) - number;
    if (number > -1000 && number < 1000) {
      return "$number.${floatingNumber.toStringAsFixed(lengthAfterDecimal ?? 4).substring(2)}";
    }
    final String digits = number.abs().toString();
    final StringBuffer result = StringBuffer(number < 0 ? '-' : '');
    final int maxDigitIndex = digits.length - 1;
    for (int i = 0; i <= maxDigitIndex; i += 1) {
      result.write(digits[i]);
      if (i < maxDigitIndex && (maxDigitIndex - i) % 3 == 0) result.write(',');
    }
    return "$result.${floatingNumber.toStringAsFixed(lengthAfterDecimal ?? 4).substring(2)}";
  }

  String emailFormat([int? number = 3]) {
    if (length > 3 && contains('@')) {
      return "${split('@').first.substring(0, number).padRight(split('@').first.length, '*')}@${split('@').last}";
    }
    return this;
  }

  String phoneFormat() {
    if (length > 6) {
      return substring(0, 3).padRight(length - 3, '*') + substring(length - 3, length);
    }
    return this;
  }
}

extension $NullableStringExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  int toInt() {
    return this == null ? 0 : int.tryParse(this!) ?? 0;
  }

  double toDouble() {
    return this == null ? 0 : double.tryParse(this!) ?? 0.0;
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return "";
    return split(" ")
        .map((part) => part.isEmpty ? "" : "${part[0].toUpperCase()}${part.substring(1).toLowerCase()}")
        .join(" ");
  }
}
