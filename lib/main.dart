import 'package:flutter/material.dart';
import 'package:habit_tracker/theme/lightMode.dart';
import 'package:habit_tracker/theme/darkMode.dart';
import 'package:habit_tracker/theme/themeSetter.dart';
import 'screens/homePage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeSetter(),
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
