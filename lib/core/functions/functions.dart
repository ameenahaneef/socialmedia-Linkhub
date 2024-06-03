 import 'package:intl/intl.dart';


String formatTimestamp(String? timestamp) {
  if (timestamp == null) return 'Invalid Time';
  try {
    String cleanedTimestamp = timestamp.split(' ').sublist(0, 2).join(' ');
    DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(cleanedTimestamp);
    return DateFormat('h:mm:a').format(dateTime);
  } catch (e) {
    return 'Invalid Time';
  }
}

String formatDate(String timestamp) {
    DateTime date = DateTime.parse(timestamp.split(" ")[0]);

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

    if (date.isAtSameMomentAs(today)) {
      return 'Today';
    } else if (date.isAtSameMomentAs(yesterday)) {
      return 'Yesterday';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

