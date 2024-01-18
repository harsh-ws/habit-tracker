import 'package:flutter/material.dart';
import 'package:habit_tracker/theme/themeSetter.dart';
import 'screens/homePage.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker/database/habitDatabase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initialize database
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunceDate();

  runApp(
    MultiProvider(
      providers: [
        //Habit Provider
        ChangeNotifierProvider(create: (context) => HabitDatabase()),

        //Theme Provider
        ChangeNotifierProvider(create: (context) => ThemeSetter())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: Provider.of<ThemeSetter>(context).themeData,
    );
  }
}
