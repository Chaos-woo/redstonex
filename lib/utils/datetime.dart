import 'package:intl/intl.dart';

/// date_utils（version：0.1.0+2） : https://github.com/apptreesoftware/date_utils
/// @Author: aleksanderwozniak
/// @GitHub: https://github.com/aleksanderwozniak/table_calendar
/// @Description: Date Util.
class rDatetime {
  static final rDatetime _single = rDatetime._internal();

  rDatetime._internal();

  factory rDatetime() => _single;

  static final DateFormat _yyyyMMddFormat = DateFormat('yyyy-MM-dd');
  static final DateFormat _yy0MM0ddFormat = DateFormat('yy.MM.dd');
  static final DateFormat _yyyyMMddHHmmssFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  static final DateFormat _HHmmFormat = DateFormat('HH:mm');
  static final DateFormat _beginOfDayFormat = DateFormat('yyyy-MM-dd 00:00:00');
  static final DateFormat _endOfDayFormat = DateFormat('yyyy-MM-dd 23:59:59');

  String yyyyMMddFormat(DateTime d) => _yyyyMMddFormat.format(d);

  String yy0MM0ddFormat(DateTime d) => _yy0MM0ddFormat.format(d);

  String yyyyMMddHHmmssFormat(DateTime d) => _yyyyMMddHHmmssFormat.format(d);

  String HHmmFormat(DateTime d) => _HHmmFormat.format(d);

  String beginOfDayFormat(DateTime d) => _beginOfDayFormat.format(d);

  String endOfDayFormat(DateTime d) => _endOfDayFormat.format(d);

  static const List<String> weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  /// 周一开始
  List<DateTime> daysInMonth(DateTime month) {
    final first = firstDayOfMonth(month);
    final daysBefore = first.weekday - 1;
    var firstToDisplay = first.subtract(Duration(days: daysBefore));

    if (firstToDisplay.hour == 23) {
      firstToDisplay = firstToDisplay.add(const Duration(hours: 1));
    }

    var last = lastDayOfMonth(month);

    if (last.hour == 23) {
      last = last.add(const Duration(hours: 1));
    }

    var daysAfter = 7 - last.weekday;

    daysAfter++;

    var lastToDisplay = last.add(Duration(days: daysAfter));

    if (lastToDisplay.hour == 1) {
      lastToDisplay = lastToDisplay.subtract(const Duration(hours: 1));
    }

    return daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  bool isFirstDayOfMonth(DateTime day) {
    return isSameDay(firstDayOfMonth(day), day);
  }

  bool isLastDayOfMonth(DateTime day) {
    return isSameDay(lastDayOfMonth(day), day);
  }

  DateTime firstDayOfMonth(DateTime month) {
    return DateTime(month.year, month.month);
  }

  DateTime firstDayOfWeek(DateTime day) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    day = DateTime.utc(day.year, day.month, day.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar works from Sunday - Monday
    final decreaseNum = day.weekday % 7;
    return day.subtract(Duration(days: decreaseNum));
  }

  DateTime lastDayOfWeek(DateTime day) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    day = DateTime.utc(day.year, day.month, day.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar's Week starts on Sunday
    final increaseNum = day.weekday % 7;
    return day.add(Duration(days: 7 - increaseNum));
  }

  /// The last day of a given month
  DateTime lastDayOfMonth(DateTime month) {
    final beginningNextMonth = (month.month < 12) ? DateTime(month.year, month.month + 1) : DateTime(month.year + 1);
    return beginningNextMonth.subtract(const Duration(days: 1));
  }

  /// Returns a [DateTime] for each day the given range.
  ///
  /// [start] inclusive
  /// [end] exclusive
  Iterable<DateTime> daysInRange(DateTime start, DateTime end) sync* {
    var i = start;
    var offset = start.timeZoneOffset;
    while (i.isBefore(end)) {
      yield i;
      i = i.add(const Duration(days: 1));
      final timeZoneDiff = i.timeZoneOffset - offset;
      if (timeZoneDiff.inSeconds != 0) {
        offset = i.timeZoneOffset;
        i = i.subtract(Duration(seconds: timeZoneDiff.inSeconds));
      }
    }
  }

  /// Whether or not two times are on the same day.
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool isSameWeek(DateTime a, DateTime b) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    a = DateTime.utc(a.year, a.month, a.day);
    b = DateTime.utc(b.year, b.month, b.day);

    final diff = a.toUtc().difference(b.toUtc()).inDays;
    if (diff.abs() >= 7) {
      return false;
    }

    final min = a.isBefore(b) ? a : b;
    final max = a.isBefore(b) ? b : a;
    final result = max.weekday % 7 - min.weekday % 7 >= 0;
    return result;
  }

  DateTime previousMonth(DateTime m) {
    var year = m.year;
    var month = m.month;
    if (month == 1) {
      year--;
      month = 12;
    } else {
      month--;
    }
    return DateTime(year, month);
  }

  DateTime nextMonth(DateTime m) {
    var year = m.year;
    var month = m.month;

    if (month == 12) {
      year++;
      month = 1;
    } else {
      month++;
    }
    return DateTime(year, month);
  }

  DateTime previousWeek(DateTime w) {
    return w.subtract(const Duration(days: 7));
  }

  DateTime nextWeek(DateTime w) {
    return w.add(const Duration(days: 7));
  }

  String previousWeekToString(DateTime w) {
    return yy0MM0ddFormat(w.subtract(const Duration(days: 6)));
  }

  DateTime previousDay(DateTime w) {
    return w.subtract(const Duration(days: 1));
  }

  DateTime nextDay(DateTime w) {
    return w.add(const Duration(days: 1));
  }

  List<DateTime> daysInWeek(DateTime week) {
    final first = _firstDayOfWeek(week);
    final last = _lastDayOfWeek(week);

    final days = daysInRange(first, last);
    return days.map((day) => DateTime(day.year, day.month, day.day)).toList();
  }

  DateTime _firstDayOfWeek(DateTime day) {
    day = DateTime.utc(day.year, day.month, day.day, 12);

    final decreaseNum = day.weekday - 1;
    return day.subtract(Duration(days: decreaseNum));
  }

  DateTime _lastDayOfWeek(DateTime day) {
    day = DateTime.utc(day.year, day.month, day.day, 12);

    final increaseNum = day.weekday - 1;
    return day.add(Duration(days: 7 - increaseNum));
  }

  bool isExtraDay(DateTime day, DateTime now) {
    return _isExtraDayBefore(day, now) || _isExtraDayAfter(day, now);
  }

  bool _isExtraDayBefore(DateTime day, DateTime now) {
    return day.month < now.month;
  }

  bool _isExtraDayAfter(DateTime day, DateTime now) {
    return day.month > now.month;
  }
}
