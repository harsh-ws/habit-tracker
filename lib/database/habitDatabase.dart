import 'package:habit_tracker/models/appSettings.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  // INITIALIZE
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HabitSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

  // Saving the first date of App Startup to fill our HeatMap
  Future<void> saveFirstLaunceDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstDoneDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  // Retrieve first date of application launch for our heatmap
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstDoneDate;
  }

  //list of habits
  final List<Habit> currentHabits = [];
  // add a new habit
  Future<void> addHabit(String habitName) async {
    // creating a new habit
    final newHabit = Habit()..name = habitName;

    // add the current habit to database
    await isar.writeTxn(() => isar.habits.put(newHabit));

    // re-read from db
    readHabits();
  }

  // Read habits from database
  Future<void> readHabits() async {
    // read all habits from db
    List<Habit> fetchedHabits = await isar.habits.where().findAll();

    // give to current habits
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);

    //updateUI
    notifyListeners();
  }

  Future<void> updateHabitProgress(int id, bool isCompleted) async {
    // find the habit by id
    final habit = await isar.habits.get(id);

    // update the habit status
    if (habit != null) {
      await isar.writeTxn(() async {
        if (isCompleted && !habit.finishedDays.contains(DateTime.now())) {
          final today = DateTime.now();
          habit.finishedDays.add(
            DateTime(today.year, today.month, today.day),
          );
        }
        // if habit not finished today then remove current date from list
        else {
          // remove today's day if habit not completed
          habit.finishedDays.removeWhere(
            (date) =>
                date.year == DateTime.now().year &&
                date.month == DateTime.now().month &&
                date.day == DateTime.now().day,
          );
        }
        // save back to the database
        await isar.habits.put(habit);

        // read the updated database
        readHabits();
      });
    }
  }

  // Update habit name in the database and re-read the new one
  Future<void> updateHabitName(int id, String newName) async {
    final habit = await isar.habits.get(id);
    if (habit != null){
      await isar.writeTxn(() async{
        habit.name = newName;
        await isar.habits.put(habit);
      });
    }
    //read the updated database
    readHabits();
  }

  // Delete the habit from the database
  Future<void> deleteHabit(int id) async{
    await isar.writeTxn(() async{
      await isar.habits.delete(id);
    });
    // read the updated database
    readHabits();
  }
}
  
