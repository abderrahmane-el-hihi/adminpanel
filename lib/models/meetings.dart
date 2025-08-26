import 'package:flutter/material.dart';

class Meeting {
  final String title;
  final String timeRange;
  final DateTime date;
  final List<String> attendees;
  final Color indicatorColor;

  Meeting({
    required this.title,
    required this.timeRange,
    required this.date,
    required this.attendees,
    required this.indicatorColor,
  });
}
