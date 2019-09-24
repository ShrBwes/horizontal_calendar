import 'package:intl/intl.dart';

class Utils {
  static String getDayOfWeek(DateTime date) => DateFormat('EEE').format(date);

  static String getDayOfMonth(DateTime date) => DateFormat('dd').format(date);

  static String getDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);
}
