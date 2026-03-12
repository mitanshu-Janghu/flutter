import 'package:flutter/material.dart';

class ReadingSupportScreen extends StatelessWidget {
  const ReadingSupportScreen({super.key});

  Widget tutorCard(String name, String subject, String experience) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [

          const CircleAvatar(
            radius: 28,
            backgroundColor: Colors.green,
            child: Icon(Icons.person, color: Colors.white),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),

                Text(
                  subject,
                  style: const TextStyle(color: Colors.white70),
                ),

                Text(
                  experience,
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
            child: const Text("Contact"),
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
        title: const Text("1:1 Reading Support"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Connect with Professional Tutors",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Get personal help understanding difficult reading material.",
              style: TextStyle(color: Colors.white54),
            ),

            const SizedBox(height: 25),

            tutorCard(
              "Dr. Sarah Johnson",
              "Reading Specialist",
              "10 years experience",
            ),

            tutorCard(
              "Prof. Michael Lee",
              "English Literature",
              "8 years experience",
            ),

            tutorCard(
              "Dr. Emily Brown",
              "Academic Reading Coach",
              "12 years experience",
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(16),
                ),
                onPressed: () {},
                child: const Text(
                  "Request New Tutor",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}