import 'package:flutter/material.dart';
import 'package:habit_tracker/components/drawer.dart';
import 'package:habit_tracker/database/habitDatabase.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker/components/habit_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // Read the existing habits on App starup
    Provider.of<HabitDatabase>(context, listen: false).readHabits();
    super.initState();
  }

  // Function to check if the habit is done today
  bool isFinishedToday(List<DateTime> finishedDays) {
    final today = DateTime.now();
    return finishedDays.any((date) =>
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day);
  }

  //text input controller
  final TextEditingController habitInput = TextEditingController();

  //create a new habit
  void createNewHabit() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: habitInput,
                decoration:
                    const InputDecoration(hintText: "Create a New Habit"),
              ),
              actions: [
                //Save Button
                MaterialButton(
                  onPressed: () {
                    // Get the habit name
                    String newHabit = habitInput.text;

                    // Store the habit in the database
                    context.read<HabitDatabase>().addHabit(newHabit);

                    // Close the dialog box
                    Navigator.pop(context);

                    // Clear the input controller
                    habitInput.clear();
                  },
                  child: const Text('Save'),
                ),

                //Cancel Button
                MaterialButton(
                  onPressed: () {
                    // Close the Alert Dialog
                    Navigator.pop(context);

                    // Clear the input controller
                    habitInput.clear();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ));
  }

  // Check off the completed habits on completion
  void crossFinishedHabits(bool? value, Habit habit){
    if (value != null){
      context.read<HabitDatabase>().updateHabitProgress(habit.id, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 4.0,
        shape: const CircleBorder(),
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: _buildHabitList(),
    );
  }

  // Building habit list
  Widget _buildHabitList() {
    // Read current habits from the database
    final habitDatabase = context.watch<HabitDatabase>();

    // Store the current habits in a List of Widgets
    List<Habit> currentHabits = habitDatabase.currentHabits;

    // Return the current habit list
    return ListView.builder(
      itemCount: currentHabits.length,
      itemBuilder: (context, index) {
        // Get each habit from the list
        final habit = currentHabits[index];

        // Check if the habit has been finished today.
        bool isDoneToday = isFinishedToday(habit.finishedDays);

        // Return the habit
        return HabitTile(text: habit.name, 
            isFinished: isDoneToday, 
            onChanged:(value) => crossFinishedHabits(value, habit));
      },
    );
  }
}
