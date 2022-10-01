import 'package:intl/intl.dart';

class Utility {

  static String tsToDate(int ts, [String? format]) {
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);
    return DateFormat(format ??='dd-MMM-yyy hh:mm a').format(dt);
  }
}