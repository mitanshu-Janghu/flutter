import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  int questionIndex = 0;
  int score = 0;

  List<Map<String, dynamic>> questions = [
    {
      "question": "What is the capital of France?",
      "answers": [
        {"text": "Paris", "correct": true},
        {"text": "London", "correct": false},
        {"text": "Berlin", "correct": false},
        {"text": "Madrid", "correct": false}
      ]
    },
    {
      "question": "Who discovered gravity?",
      "answers": [
        {"text": "Newton", "correct": true},
        {"text": "Einstein", "correct": false},
        {"text": "Tesla", "correct": false},
        {"text": "Galileo", "correct": false}
      ]
    },
    {
      "question": "What is 5 + 7 ?",
      "answers": [
        {"text": "12", "correct": true},
        {"text": "10", "correct": false},
        {"text": "14", "correct": false},
        {"text": "11", "correct": false}
      ]
    }
  ];

  void answerQuestion(bool correct) {

    if (correct) {
      score++;
    }

    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
      });
    } else {
      showResult();
    }
  }

  void showResult() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Quiz Completed"),
        content: Text("Your Score: $score / ${questions.length}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Close"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    var currentQuestion = questions[questionIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Mini Quiz"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            Text(
              currentQuestion["question"],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 30),

            ...(currentQuestion["answers"] as List).map((answer) {

              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 15),

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    padding: const EdgeInsets.all(15),
                  ),

                  onPressed: () => answerQuestion(answer["correct"]),

                  child: Text(
                    answer["text"],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}