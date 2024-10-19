import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String formatToCustomString({
    String pattern = 'd MMM, yyyy. HH:mm',
  }) {
    final formattedDate = DateFormat(pattern).format(this);
    return formattedDate;
  }
}