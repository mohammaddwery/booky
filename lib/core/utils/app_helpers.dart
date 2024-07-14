import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String get format => DateFormat('yyyy-MM-dd').format(this);
}