import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StudyGoalsScreen extends StatefulWidget {
  const StudyGoalsScreen({super.key});

  @override
  State<StudyGoalsScreen> createState() => _StudyGoalsScreenState();
}

class _StudyGoalsScreenState extends State<StudyGoalsScreen> {

  List<Map<String, dynamic>> goals = [];
  TextEditingController goalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadGoals();
  }

  /// LOAD GOALS
  Future<void> loadGoals() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("goals");

    if (data != null) {
      setState(() {
        goals = List<Map<String, dynamic>>.from(json.decode(data));
      });
    }
  }

  /// SAVE GOALS
  Future<void> saveGoals() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("goals", json.encode(goals));
  }

  /// ADD GOAL
  void addGoal() {
    if (goalController.text.isEmpty) return;

    setState(() {
      goals.add({
        "title": goalController.text,
        "done": false,
      });
    });

    goalController.clear();
    saveGoals();
  }

  /// TOGGLE COMPLETE
  void toggleGoal(int index) {
    setState(() {
      goals[index]["done"] = !goals[index]["done"];
    });

    saveGoals();
  }

  /// DELETE GOAL
  void deleteGoal(int index) {
    setState(() {
      goals.removeAt(index);
    });

    saveGoals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(
        title: const Text("Study Goals"),
        backgroundColor: Colors.black,
      ),

      body: Column(
        children: [

          /// INPUT
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: goalController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Enter study goal...",
                      hintStyle: TextStyle(color: Colors.white54),
                    ),
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green),
                  onPressed: addGoal,
                )
              ],
            ),
          ),

          /// GOAL LIST
          Expanded(
            child: ListView.builder(
              itemCount: goals.length,
              itemBuilder: (context, index) {

                final goal = goals[index];

                return ListTile(
                  title: Text(
                    goal["title"],
                    style: TextStyle(
                      color: Colors.white,
                      decoration: goal["done"]
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),

                  leading: Checkbox(
                    value: goal["done"],
                    onChanged: (value) {
                      toggleGoal(index);
                    },
                  ),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      deleteGoal(index);
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}