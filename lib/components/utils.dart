import 'package:flutter/material.dart';

import '../models/habit.dart';

// Function to check if the habit is done today
bool isFinishedToday(List<DateTime> finishedDays) {
  final today = DateTime.now();
  return finishedDays.any((date) =>
      date.year == today.year &&
      date.month == today.month &&
      date.day == today.day);
}

// Dataset for the Heatmap
Map<DateTime, int> prepareHeatMapData(List<Habit> habits){
  // Creating a dataset to be returned
  Map<DateTime,int> dataset= {};

  // Iterate through the current habits.
  for (var habit in habits){
    for (var date in habit.finishedDays){
      final habitDoneDate = DateTime(date.year,date.month,date.day);

      if (dataset.containsKey(habitDoneDate)){
        dataset[habitDoneDate] = dataset[habitDoneDate]! + 1;
      }
      else{
        dataset[habitDoneDate] = 1;
      }
    }
  }
  return dataset;
}