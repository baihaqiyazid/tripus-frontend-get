import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

String formatTimeAgo(String datetimeString) {
  final parsedDatetime = DateTime.parse(datetimeString);
  final now = DateTime.now();

  final difference = now.difference(parsedDatetime);

  return timeago.format(now.subtract(difference), locale: 'en_short');
}