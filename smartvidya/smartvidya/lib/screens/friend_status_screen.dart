import 'package:flutter/material.dart';

class FriendStatusScreen extends StatelessWidget {
  const FriendStatusScreen({super.key});

  final List<Map<String, dynamic>> friends = const [
    {"name": "Aman", "done": true},
    {"name": "Riya", "done": false},
    {"name": "Karan", "done": true},
    {"name": "Neha", "done": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(
        title: const Text("Friend Study Status"),
        backgroundColor: Colors.black,
      ),

      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {

          final friend = friends[index];

          return ListTile(

            leading: const CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.person, color: Colors.white),
            ),

            title: Text(
              friend["name"],
              style: const TextStyle(color: Colors.white),
            ),

            subtitle: Text(
              friend["done"]
                  ? "Completed today's assignment"
                  : "Not completed yet",
              style: TextStyle(
                color: friend["done"]
                    ? Colors.green
                    : Colors.red,
              ),
            ),

            trailing: Icon(
              friend["done"]
                  ? Icons.check_circle
                  : Icons.cancel,
              color: friend["done"]
                  ? Colors.green
                  : Colors.red,
            ),
          );
        },
      ),
    );
  }
}