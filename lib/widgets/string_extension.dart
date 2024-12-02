import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

extension StringExtension on String {
  String toCapitalize() =>
      '${this[0].toUpperCase()}${substring(1).toLowerCase()}';

  String toCapitalizeFirstOfEach() =>
      _groupIntoWords(this).map((str) => str.toCapitalize()).join(' ');

  String toCamelCase() {
    List<String> words =
        _groupIntoWords(this).map((word) => word.toCapitalize()).toList();
    String res = words.join('');
    return '${res[0].toLowerCase()}${res.substring(1)}';
  }

  String toSnakeCase() {
    List<String> words =
        _groupIntoWords(this).map((word) => word.toLowerCase()).toList();
    return words.join('_');
  }

  List<String> _groupIntoWords(String text) {
    StringBuffer sb = StringBuffer();
    List<String> words = [];
    bool isAllCaps = text.toUpperCase() == text;
    final symbolSet = {' ', '.', '/', '_', '\\', '-'};
    final RegExp upperAlphaRegex = RegExp(r'[A-Z]');

    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      String? nextChar = i + 1 == text.length ? null : text[i + 1];

      if (symbolSet.contains(char)) {
        continue;
      }

      sb.write(char);

      bool isEndOfWord = nextChar == null ||
          (upperAlphaRegex.hasMatch(nextChar) && !isAllCaps) ||
          symbolSet.contains(nextChar);

      if (isEndOfWord) {
        words.add(sb.toString());
        sb.clear();
      }
    }

    return words;
  }

  bool get isDouble {
    return double.tryParse(this) != null;
  }

  bool get isInt {
    return int.tryParse(this) != null;
  }

  bool get isBool {
    return this == 'true' || this == 'false';
  }

  String toFormatDate(String format) {
    return DateFormat(format).format(DateTime.parse(this));
  }

  DateTime toDateTime() {
    try {
      return DateTime.parse(this);
    } catch (e) {
      return DateFormat('dd/MM/yyyy').parse(this);
    }
  }

  List<String> toStringList() {
    final List<dynamic> list = json.decode(this);
    return list.map((e) => e.toString()).toList();
  }

  DateTime? tryParseFormat(String format) {
    try {
      return DateFormat(format).parseStrict(this);
    } catch (e) {
      return null;
    }
  }
}
