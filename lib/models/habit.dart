import 'package:isar/isar.dart';
part 'habit.g.dart';

@Collection()
class Habit{
    Id id = Isar.autoIncrement; //habit id
    late String name;           //habit name
    List<DateTime> finishedDays = [
    // DateTime(year, month, day)
    // DateTime(2024, 1, 12)
  ];
}