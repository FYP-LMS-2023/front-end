//utility function to get the time left
// ignore: non_constant_identifier_names
String time_left(date) {
  Duration difference = date.difference(DateTime.now());

  String timeLeft = '';

  if (difference.inDays > 0) {
    timeLeft += '${difference.inDays}d ';
  }
  if (difference.inHours > 0) {
    timeLeft += '${difference.inHours % 24}h ';
  }
  if (difference.inMinutes > 0) {
    timeLeft += '${difference.inMinutes % 60}m ';
  }
  if (difference.inSeconds > 0 && difference.inHours == 0) {
    timeLeft += '${difference.inSeconds % 60}s ';
  }
  if (difference.inSeconds <= 0) {
    timeLeft = 'Expired';
  }

  return timeLeft;
}
