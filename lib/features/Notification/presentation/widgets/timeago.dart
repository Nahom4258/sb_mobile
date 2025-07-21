import 'package:flutter/material.dart';

class TimeAgo extends StatelessWidget {
  final DateTime dateTime;

  const TimeAgo({super.key, required this.dateTime});

  String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return "${difference.inSeconds}s";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d";
    } else if ((difference.inDays / 7).floor() < 4) {
      return "${(difference.inDays / 7).floor()}w";
    } else if ((difference.inDays / 30).floor() < 12) {
      if ((difference.inDays / 30).floor() == 0) {
        return "1mo";
      }
      return "${(difference.inDays / 30).floor()}mo";
    } else {
      return "${(difference.inDays / 365).floor()}y";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formatTimeAgo(dateTime),
      style: const TextStyle(
          fontSize: 13, color: Color.fromARGB(255, 108, 108, 108)),
    );
  }
}
