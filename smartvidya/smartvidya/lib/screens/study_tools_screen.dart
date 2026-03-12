import 'package:flutter/material.dart';
import 'pomodoro_timer_screen.dart';
import 'study_streak_screen.dart';
import 'progress_analytics_screen.dart';
import 'smart_reminder_screen.dart';
import 'study_goals_screen.dart';
import 'friend_status_screen.dart';
class StudyToolsScreen extends StatelessWidget {
  const StudyToolsScreen({super.key});

  Widget toolTile(
      String title,
      String subtitle,
      IconData icon,
      VoidCallback? action,
      ) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: const TextStyle(color: Colors.white)),
          subtitle: Text(subtitle, style: const TextStyle(color: Colors.white54)),
          trailing: CircleAvatar(
            backgroundColor: const Color(0xFF2A2A2A),
            child: Icon(icon, color: Colors.white),
          ),
          onTap: action,
        ),
        const Divider(color: Colors.white12)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(
        title: const Text("Study Tools"),
        backgroundColor: Colors.black,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            /// POMODORO TIMER
            toolTile(
              "Pomodoro Study Timer",
              "25 min study • 5 min break",
              Icons.timer,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PomodoroTimerScreen(),
                  ),
                );
              },
            ),

            /// STUDY STREAK
            toolTile(
  "Study Streak",
  "Track daily learning streak",
  Icons.local_fire_department,
  () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StudyStreakScreen(),
      ),
    );
  },
),

            /// PROGRESS ANALYTICS
            toolTile(
  "Progress Analytics",
  "See your study improvement",
  Icons.show_chart,
  () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProgressAnalyticsScreen(),
      ),
    );
  },
),
            /// SMART REMINDERS
            toolTile(
  "Smart Reminders",
  "Daily study notifications",
  Icons.notifications,
  () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SmartReminderScreen(),
      ),
    );
  },
),

            /// STUDY GOALS
            toolTile(
  "Study Goals",
  "Set daily / weekly goals",
  Icons.flag,
  () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StudyGoalsScreen(),
      ),
    );
  },
),
//frnd
toolTile(
  "Friend Study Status",
  "See if friends completed assignment",
  Icons.people,
  () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FriendStatusScreen(),
      ),
    );
  },
),
          ],
        ),
      ),
    );
  }
}