import 'package:intl/intl.dart';

class Formatter {
  /// Convert a double [value] to a currency
  static String money(double value) {
    final nf = NumberFormat("#,###", "en_US");
    return nf.format(value);
  }

  /// Converting [dateTime] in string format to return a formatted time
  /// of hrs, minutes and am/pm
  static String getFormattedDate(DateTime dateTime) {
    return DateFormat('yMd').format(dateTime).toString();
  }

  /// Converting [dateTime] in string format to return a formatted time
  /// of hrs, minutes and am/pm
  static String getFormattedTime(DateTime dateTime) {
    return DateFormat('h:mm').format(dateTime).toString();
  }

  /// Method to capitalize the first letter of each word in [string]
  static String capitalize(String string) {
    String result = '';

    if (string.isEmpty) {
      return string;
    } else {
      List<String> values = string.split(' ');
      List<String> valuesToJoin = [];

      if (values.length == 1) {
        result = string[0].toUpperCase() + string.substring(1);
      } else {
        for (int i = 0; i < values.length; i++) {
          if (values[i].isNotEmpty) {
            valuesToJoin
                .add(values[i][0].toUpperCase() + values[i].substring(1));
          }
        }
        result = valuesToJoin.join(' ');
      }
    }
    return result;
  }
}
