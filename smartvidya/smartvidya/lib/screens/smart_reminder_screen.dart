import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SmartReminderScreen extends StatefulWidget {
  const SmartReminderScreen({super.key});

  @override
  State<SmartReminderScreen> createState() => _SmartReminderScreenState();
}

class _SmartReminderScreenState extends State<SmartReminderScreen> {

  bool reminderEnabled = false;

  @override
  void initState() {
    super.initState();
    loadReminder();
  }

  Future<void> loadReminder() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      reminderEnabled = prefs.getBool("reminder") ?? false;
    });
  }

  Future<void> toggleReminder() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      reminderEnabled = !reminderEnabled;
    });

    await prefs.setBool("reminder", reminderEnabled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(
        title: const Text("Smart Reminder"),
        backgroundColor: Colors.black,
      ),

      body: Center(
        child: SwitchListTile(
          title: const Text(
            "Daily Study Reminder",
            style: TextStyle(color: Colors.white),
          ),
          subtitle: const Text(
            "Get reminded to study everyday",
            style: TextStyle(color: Colors.white54),
          ),
          value: reminderEnabled,
          onChanged: (value) {
            toggleReminder();
          },
        ),
      ),
    );
  }
}