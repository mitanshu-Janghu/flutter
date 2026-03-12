import 'package:flutter/material.dart';

class ClassScreen extends StatelessWidget {
  const ClassScreen({super.key});

  Widget classCard(String title, String teacher, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [

          const CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.school, color: Colors.white),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 4),

                Text(
                  "Teacher: $teacher",
                  style: const TextStyle(color: Colors.white70),
                ),

                Text(
                  "Time: $time",
                  style: const TextStyle(color: Colors.white54),
                ),
              ],
            ),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: () {},
            child: const Text("Join"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Classes"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Upcoming Classes",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            classCard(
              "Mathematics Group Session",
              "Dr. Smith",
              "10:00 AM",
            ),

            classCard(
              "Physics Problem Solving",
              "Prof. Johnson",
              "12:30 PM",
            ),

            classCard(
              "English Reading Workshop",
              "Ms. Emma",
              "3:00 PM",
            ),

            classCard(
              "Chemistry Quick Revision",
              "Dr. Lee",
              "5:30 PM",
            ),
          ],
        ),
      ),
    );
  }
}