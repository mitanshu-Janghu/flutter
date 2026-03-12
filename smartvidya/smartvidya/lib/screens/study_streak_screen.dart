import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudyStreakScreen extends StatefulWidget {
  const StudyStreakScreen({super.key});

  @override
  State<StudyStreakScreen> createState() => _StudyStreakScreenState();
}

class _StudyStreakScreenState extends State<StudyStreakScreen> {

  int streak = 0;
  String lastDate = "";

  @override
  void initState() {
    super.initState();
    loadStreak();
  }

  Future<void> loadStreak() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      streak = prefs.getInt("streak") ?? 0;
      lastDate = prefs.getString("lastDate") ?? "";
    });
  }

  Future<void> markStudyDone() async {
    final prefs = await SharedPreferences.getInstance();

    DateTime today = DateTime.now();
    String todayString = "${today.year}-${today.month}-${today.day}";

    if (lastDate != todayString) {
      setState(() {
        streak++;
        lastDate = todayString;
      });

      await prefs.setInt("streak", streak);
      await prefs.setString("lastDate", todayString);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(
        title: const Text("Study Streak"),
        backgroundColor: Colors.black,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.local_fire_department,
              color: Colors.orange,
              size: 80,
            ),

            const SizedBox(height: 20),

            Text(
              "$streak Day Streak",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: markStudyDone,
              child: const Text("I Studied Today"),
            ),
          ],
        ),
      ),
    );
  }
}