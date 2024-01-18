import 'package:flutter/material.dart';

// Function to check if the habit is done today
bool isFinishedToday(List<DateTime> finishedDays) {
  final today = DateTime.now();
  return finishedDays.any((date) =>
      date.year == today.year &&
      date.month == today.month &&
      date.day == today.day);
}