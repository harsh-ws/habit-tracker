import 'package:isar/isar.dart';
part 'appSettings.g.dart';

@Collection()
class AppSettings{
    Id id = Isar.autoIncrement;
    DateTime? firstDoneDate;
}