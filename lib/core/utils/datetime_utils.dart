import 'package:intl/intl.dart';

class DatetimeUtils {
  static String getCurrentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MMMM dd, yyyy');
    return formatter.format(now);
  }
}
