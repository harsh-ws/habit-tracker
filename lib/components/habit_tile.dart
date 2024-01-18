import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/habitDatabase.dart';
import 'utils.dart';

class HabitTile extends StatelessWidget {
  final bool isFinished;
  final String text;
  final void Function(bool?)? onChanged;

  const HabitTile(
      {super.key,
      required this.text,
      required this.isFinished,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isFinished
              ? Colors.green
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(6)),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(12),
      child: ListTile(
        title: Text(text),
        leading: Checkbox(
          value: isFinished,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
