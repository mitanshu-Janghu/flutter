import 'package:flutter/material.dart';
import 'dart:async';

class PomodoroTimerScreen extends StatefulWidget {
  const PomodoroTimerScreen({super.key});

  @override
  State<PomodoroTimerScreen> createState() => _PomodoroTimerScreenState();
}

class _PomodoroTimerScreenState extends State<PomodoroTimerScreen> {

  static const int studyTime = 25 * 60;
  static const int breakTime = 5 * 60;

  int remainingSeconds = studyTime;
  bool isRunning = false;
  bool isStudy = true;

  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        switchMode();
      }
    });

    setState(() {
      isRunning = true;
    });
  }

  void pauseTimer() {
    timer?.cancel();

    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    timer?.cancel();

    setState(() {
      remainingSeconds = isStudy ? studyTime : breakTime;
      isRunning = false;
    });
  }

  void switchMode() {
    timer?.cancel();

    setState(() {
      isStudy = !isStudy;
      remainingSeconds = isStudy ? studyTime : breakTime;
      isRunning = false;
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;

    return "$minutes:${secs.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(
        title: const Text("Pomodoro Timer"),
        backgroundColor: Colors.black,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(
            isStudy ? "Study Time" : "Break Time",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 22,
            ),
          ),

          const SizedBox(height: 30),

          Text(
            formatTime(remainingSeconds),
            style: const TextStyle(
              color: Colors.green,
              fontSize: 80,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ElevatedButton(
                onPressed: isRunning ? pauseTimer : startTimer,
                child: Text(isRunning ? "Pause" : "Start"),
              ),

              const SizedBox(width: 20),

              ElevatedButton(
                onPressed: resetTimer,
                child: const Text("Reset"),
              ),
            ],
          )
        ],
      ),
    );
  }
}