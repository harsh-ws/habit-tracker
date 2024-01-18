import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker/theme/themeSetter.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 2.0,
      surfaceTintColor: Colors.green,
      child: Center(
        child: CupertinoSwitch(
          value: Provider.of<ThemeSetter>(context).isDarkMode,
          onChanged: (value) =>
              Provider.of<ThemeSetter>(context, listen: false).toggleTheme(),
        ),
      ),
    );
  }
}
