import 'package:intl/intl.dart';

abstract final class AppDateUtils {
  static final _apiDate = DateFormat('yyyy-MM-dd');

  static String toApiDate(DateTime value) => _apiDate.format(value);
}
