import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String toFormat(String format, [String? locale]) {
    return DateFormat(format, locale).format(this);
  }

  String toFormattedString() {
    return DateFormat('dd/MM/yy').format(this);
  }

  String toFormattedStringPurchase() {
    return DateFormat('dd-MM-yy').format(this);
  }

  String toHumanizeTime() {
    return toFormat('h:mm a').toLowerCase();
  }

  static String convertToIsoFormat(String dateString,
      {String inputFormat = 'dd/MM/yy', String outputFormat = 'yyyy-MM-dd'}) {
    final dateTime =
        DateFormat(inputFormat).parse(dateString).add(const Duration(days: 1));
    return DateFormat(outputFormat).format(dateTime);
  }
}
