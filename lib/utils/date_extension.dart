import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String toFormattedString() {
    return DateFormat('dd/MM/yy').format(this);
  }
}
