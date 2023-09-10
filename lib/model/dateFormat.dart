// TimeStampをDAteTimeに変換する
// yyyy-MM-dd HH:mm:ss.SSS

import 'package:cloud_firestore/cloud_firestore.dart';

class DateFormat {
  static String convertTimeStampToDateTime(Timestamp timestamp) {
    final date = timestamp.toDate();
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    final second = date.second.toString().padLeft(2, '0');

    return '$year-$month-$day $hour:$minute:$second';
  }

  // 現在の時間から何秒前かを表示
  static String convertTimeStampToTime(Timestamp timestamp) {
    final date = timestamp.toDate();
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${difference.inDays / 7}w ago';
    }
  }
}
