import 'package:rent_tracker/core/constants/months.dart';

String formatMonth(DateTime date) {
  return '${months[date.month - 1]} ${date.year}';
}
