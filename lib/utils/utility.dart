import 'package:intl/intl.dart';

class Utility {

  static String tsToDate(int ts) {
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);
    return DateFormat('dd-MMM-yyy hh:mm a').format(dt);
  }
}