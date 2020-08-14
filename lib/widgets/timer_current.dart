import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimerCurrent{
  String readTimestamp(Timestamp timestamp) {
    var now = DateTime.now();
    var date = timestamp.toDate();
    var format = DateFormat.yMMMd().format(date);
    var diff = now.difference(date);
    var time = '';
    Duration difference = DateTime.now().difference(date);
    if (difference.inSeconds < 5) {
      return time = "Just now";
    } else if (difference.inMinutes < 1) {
      return time = "${difference.inSeconds}s ago";
    } else if (difference.inHours < 1) {
      return time = "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return time = "${difference.inHours}h ago";
    } else {
      if (diff.inSeconds <= 0 ||
          diff.inSeconds > 0 && diff.inMinutes == 0 ||
          diff.inMinutes > 0 && diff.inHours == 0 ||
          diff.inHours > 0 && diff.inDays == 0) {
        time = format.toString();
      } else if (diff.inDays > 0 && diff.inDays < 7) {
        if (diff.inDays == 1) {
          time = diff.inDays.toString() + ' day ago';
        } else {
          time = diff.inDays.toString() + ' days ago';
        }
      } else {
        if (diff.inDays == 7) {
          time = (diff.inDays / 7).floor().toString() + ' week ago';
        } else {
          time = (diff.inDays / 7).floor().toString() + ' weeks ago';
        }
      }

      return time;
    }
  }
}