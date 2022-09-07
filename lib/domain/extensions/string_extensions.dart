import 'package:intl/intl.dart';

extension StringExtensions on String? {
  bool get isNullEmptyOrWhitespace => this == null || this!.isEmpty || this!.trim().isEmpty;
  bool get isNotNullEmptyOrWhitespace => !isNullEmptyOrWhitespace;

  bool get isNullEmptyOrWhitespaceOrHasNull => this == null || this!.isEmpty || this!.contains('null');
  bool get isNotNullEmptyOrWhitespaceNorHasNull => !isNullEmptyOrWhitespaceOrHasNull;

  bool isValidLength({int minLength = 0, int maxLength = 255}) => isNotNullEmptyOrWhitespace || this!.length > maxLength || this!.length < minLength;

  String formatTimeString({bool hasYear = false}) {
    final dateTimeString = hasYear ? '$this' : '2012-02-27 $this';
    final dateTime = DateTime.parse(dateTimeString);

    final dateFormat = DateFormat('h:mm a');
    final timeString = dateFormat.format(dateTime);

    return timeString;
  }

  String formatDateString({bool hasYear = false, bool isProfile = false}) {
    final dateString = '$this';
    final date = DateTime.parse(dateString);

    final dateFormat = DateFormat(isProfile ? 'd MMMM yyyy' : hasYear ? 'yMMMd' : 'd MMM');
    final parsedDateString = dateFormat.format(date);

    return parsedDateString;
  }

  int getSecondsFromEpoch() {
    final dateString = '$this';
    final parsed = DateTime.parse(dateString).millisecondsSinceEpoch;

    return parsed;
  }

  DateTime parseDateString() {
    final dateString = '$this';
    final date = DateTime.parse(dateString);

    return date;
  }

  String formatDateTimeString() {
    final dateString = '$this';
    final date = DateTime.parse(dateString);

    final dateFormat = DateFormat('d MMM h:mm a');
    final dateTime = dateFormat.format(date);

    return dateTime;
  }
}

extension NonNullStringExtensions on String {
  String signParseDate() {
    final date = DateTime.parse(this);
    final parsedDate = DateFormat('yMd').format(date);

    return parsedDate;
  }

  String parseDateSpan(int span) {
    final parsedDate = DateTime.parse(this);

    final lastDay = parsedDate.add(Duration(days: span));
    final parsedLastDay = DateFormat('yMd').format(lastDay);

    return parsedLastDay;
  }
}