import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get formatStringWithMs {
    DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss.sss');
    return format.format(this);
  }

  String toFormatString() {
    DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
    return format.format(this);
  }

  String get datetimeString {
    DateFormat format = DateFormat('yy-MM-dd\nHH:mm:ss');
    return format.format(this);
  }

  String toDayString() {
    DateFormat format = DateFormat('yyyy/MM/dd');
    return format.format(this);
  }

  String toMonthString() {
    DateFormat format = DateFormat('MM/dd');
    return format.format(this);
  }

  String toTimeString() {
    DateFormat format = DateFormat('HH:mm:ss');
    return format.format(this);
  }

  String toTimeWithoutSecondsString() {
    DateFormat format = DateFormat('HH:mm');
    return format.format(this);
  }
}



extension OriginalDurationExtension on Duration {
  String toText() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(inHours);
    String minutes = twoDigits(inMinutes.remainder(60));
    return "$hours:$minutes";
  }
}

extension WeekDayWithIntValueExtension on int {
  String toText() {
    switch (this % 7) {
      case 1:
        return "周一";
      case 2:
        return "周二";
      case 3:
        return "周三";
      case 4:
        return "周四";
      case 5:
        return "周五";
      case 6:
        return "周六";
      case 0:
        return "周天";
      default:
        return "";
    }
  }
}
