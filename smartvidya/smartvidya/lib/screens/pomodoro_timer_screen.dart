import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class PomodoroTimerScreen extends StatefulWidget {
  const PomodoroTimerScreen({super.key});

  @override
  State<PomodoroTimerScreen> createState() => _PomodoroTimerScreenState();
}

class _PomodoroTimerScreenState extends State<PomodoroTimerScreen> {

  int totalSeconds = 25 * 60;
  int remainingSeconds = 25 * 60;

  bool isRunning = false;

  Timer? timer;

  final AudioPlayer player = AudioPlayer();

  TextEditingController minuteController = TextEditingController();

  void startTimer() {

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {

      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        playAlarm();
        pauseTimer();
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
      remainingSeconds = totalSeconds;
      isRunning = false;
    });
  }

  void setCustomTimer() {

    int minutes = int.tryParse(minuteController.text) ?? 25;

    timer?.cancel();

    setState(() {
      totalSeconds = minutes * 60;
      remainingSeconds = totalSeconds;
      isRunning = false;
    });
  }

  void playAlarm() async {
    await player.play(AssetSource('sounds/alarm.wav'));
  }

  String formatTime(int seconds) {

    int minutes = seconds ~/ 60;
    int secs = seconds % 60;

    return "$minutes:${secs.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {

    double progress = remainingSeconds / totalSeconds;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(
        title: const Text("Pomodoro Timer"),
        backgroundColor: Colors.black,
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const SizedBox(height: 40),

            /// USER TIMER INPUT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),

              child: Row(
                children: [

                  Expanded(
                    child: TextField(
                      controller: minuteController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),

                      decoration: const InputDecoration(
                        hintText: "Enter minutes",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  ElevatedButton(
                    onPressed: setCustomTimer,
                    child: const Text("Set"),
                  )
                ],
              ),
            ),

            const SizedBox(height: 60),

            /// TIMER CIRCLE
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [

                  SizedBox(
                    width: 220,
                    height: 220,

                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 10,
                      backgroundColor: Colors.grey[800],
                      valueColor: const AlwaysStoppedAnimation(Colors.green),
                    ),
                  ),

                  Text(
                    formatTime(remainingSeconds),
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            /// BUTTONS
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
            ),

            const SizedBox(height: 40),

          ],
        ),
      ),
    );
  }
}