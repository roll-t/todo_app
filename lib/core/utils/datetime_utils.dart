import 'package:intl/intl.dart';

class DatetimeUtils {
  static String getCurrentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MMMM dd, yyyy');
    return formatter.format(now);
  }

  static String formatTime(DateTime? dateTime) {
    if (dateTime == null) return "";

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final givenDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    String formatWithAmPm(DateTime time) {
      final hour =
          time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
      final period = time.hour >= 12 ? "pm" : "am";
      return "${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period";
    }

    if (givenDate == today) {
      return formatWithAmPm(dateTime);
    } else if (givenDate == today.subtract(const Duration(days: 1))) {
      return "Yesterday";
    } else if (givenDate == today.add(const Duration(days: 1))) {
      return "Tomorrow";
    } else {
      final difference = today.difference(givenDate).inDays;
      if (difference > 0) {
        if (difference == 1) {
          return "1 day ago";
        } else if (difference < 7) {
          return "$difference days ago";
        } else if (difference < 30) {
          final weeks = (difference / 7).floor();
          return weeks == 1 ? "1 week ago" : "$weeks weeks ago";
        } else if (difference < 365) {
          final months = (difference / 30).floor();
          return months == 1 ? "1 month ago" : "$months months ago";
        } else {
          final years = (difference / 365).floor();
          return years == 1 ? "1 year ago" : "$years years ago";
        }
      } else {
        final futureDifference = givenDate.difference(today).inDays;
        if (futureDifference == 1) {
          return "In 1 day";
        } else if (futureDifference < 7) {
          return "In $futureDifference days";
        } else if (futureDifference < 30) {
          final weeks = (futureDifference / 7).floor();
          return weeks == 1 ? "In 1 week" : "In $weeks weeks";
        } else if (futureDifference < 365) {
          final months = (futureDifference / 30).floor();
          return months == 1 ? "In 1 month" : "In $months months";
        } else {
          final years = (futureDifference / 365).floor();
          return years == 1 ? "In 1 year" : "In $years years";
        }
      }
    }
  }
}
