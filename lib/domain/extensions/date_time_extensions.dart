import 'package:intl/intl.dart';

extension DateTimeExceptions on DateTime {
  String formatDate() {
    final dateFormat = DateFormat('yMMMMd');
    final parsedDateString = dateFormat.format(this);

    return parsedDateString;
  }
}