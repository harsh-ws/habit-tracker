import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final bool isFinished;
  final String text;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? editHabit;
  final void Function(BuildContext)? deleteHabit;

  const HabitTile(
      {super.key,
      required this.text,
      required this.isFinished,
      required this.onChanged,
      required this.editHabit,
      required this.deleteHabit,
      });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          // edit the habit
          SlidableAction(
            onPressed: editHabit,
            backgroundColor: Colors.grey,
            icon: Icons.settings,
            borderRadius: BorderRadius.circular(6),
          ),

          // delete the habit
          SlidableAction(
            onPressed: deleteHabit,
            backgroundColor: Colors.grey,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(6),
          )
        ],
      ),
      child: GestureDetector(
        onTap: () {
          if (onChanged != null) {
            onChanged!(!isFinished);
          }
        },
        child: Container(
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
              activeColor: Colors.green,
              value: isFinished,
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }
}
