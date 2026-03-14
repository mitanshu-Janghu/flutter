import 'package:flutter/material.dart';

class FriendStatusScreen extends StatefulWidget {
  const FriendStatusScreen({super.key});

  @override
  State<FriendStatusScreen> createState() => _FriendStatusScreenState();
}

class _FriendStatusScreenState extends State<FriendStatusScreen> {

  List<String> goals = [
    "Complete Physics Numericals",
    "Revise Organic Chemistry",
    "Practice Calculus Problems",
    "Biology NCERT Revision"
  ];

  List<Map<String, dynamic>> friends = [
    {
      "name": "Aman",
      "streak": 2,
      "goalStatus": {
        "Complete Physics Numericals": true,
        "Revise Organic Chemistry": true,
        "Practice Calculus Problems": true,
        "Biology NCERT Revision": true
      }
    },
    {
      "name": "Riya",
      "streak": 1,
      "goalStatus": {
        "Complete Physics Numericals": true,
        "Revise Organic Chemistry": true,
        "Practice Calculus Problems": true,
        "Biology NCERT Revision": true
      }
    },
    {
      "name": "Karan",
      "streak": 3,
      "goalStatus": {
        "Complete Physics Numericals": true,
        "Revise Organic Chemistry": true,
        "Practice Calculus Problems": true,
        "Biology NCERT Revision": true
      }
    },
    {
      "name": "Neha",
      "streak": 2,
      "goalStatus": {
        "Complete Physics Numericals": true,
        "Revise Organic Chemistry": true,
        "Practice Calculus Problems": true,
        "Biology NCERT Revision": true
      }
    }
  ];

  String? selectedGoal;
  String? goalToRemove;

  @override
  void initState() {
    super.initState();
    selectedGoal = goals.first;
  }

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> completed = [];
    List<Map<String, dynamic>> notCompleted = [];

    if (selectedGoal != null) {

      for (var friend in friends) {

        if (friend["goalStatus"][selectedGoal] == true) {
          completed.add(friend);
        } else {
          notCompleted.add(friend);
        }

      }

    }

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(
        title: const Text("Friend Study Status"),
        backgroundColor: Colors.black,
        actions: [

          PopupMenuButton<String>(
            icon: const Icon(Icons.add),
            onSelected: (value) {

              if (value == "friend") showAddFriendDialog();
              if (value == "goal") showAddGoalDialog();
              if (value == "removeGoal") showRemoveGoalDialog();

            },
            itemBuilder: (context) => const [

              PopupMenuItem(
                value: "friend",
                child: ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text("Add Friend"),
                ),
              ),

              PopupMenuItem(
                value: "goal",
                child: ListTile(
                  leading: Icon(Icons.flag),
                  title: Text("Add Goal"),
                ),
              ),

              PopupMenuItem(
                value: "removeGoal",
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text("Remove Goal"),
                ),
              ),

            ],
          )

        ],
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              dropdownColor: Colors.black,
              value: selectedGoal,
              hint: const Text("Select Goal",
                  style: TextStyle(color: Colors.white)),
              items: goals.map((goal) {

                return DropdownMenuItem(
                  value: goal,
                  child: Text(goal,
                      style: const TextStyle(color: Colors.white)),
                );

              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedGoal = value;
                });
              },
            ),
          ),

          const Divider(color: Colors.grey),

          Expanded(
            child: ListView(
              children: [

                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Completed Goal",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                ...completed.map(friendTile),

                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Not Completed",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                ...notCompleted.map(friendTile),

              ],
            ),
          )

        ],
      ),
    );
  }

  Widget friendTile(Map<String, dynamic> friend) {

    bool done = friend["goalStatus"][selectedGoal] == true;

    return ListTile(

      leading: const CircleAvatar(
        backgroundColor: Colors.green,
        child: Icon(Icons.person, color: Colors.white),
      ),

      title: Text(friend["name"],
          style: const TextStyle(color: Colors.white)),

      subtitle: Text(
        "🔥 Study Streak: ${friend["streak"]}",
        style: const TextStyle(color: Colors.orange),
      ),

      trailing: IconButton(
        icon: Icon(
          done ? Icons.check_circle : Icons.circle_outlined,
          color: done ? Colors.green : Colors.grey,
        ),
        onPressed: () {

          if (selectedGoal == null) return;

          setState(() {

            if (!done) {
              friend["goalStatus"][selectedGoal] = true;
              friend["streak"] += 1;
            }

          });

        },
      ),
    );
  }

  void showAddFriendDialog() {

    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {

        return AlertDialog(
          title: const Text("Add Friend"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: "Friend Name"),
          ),
          actions: [

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {

                Map<String, bool> status = {};

                for (var goal in goals) {
                  status[goal] = false;
                }

                setState(() {

                  friends.insert(0,{
                    "name": controller.text,
                    "streak": 0,
                    "goalStatus": status
                  });

                });

                Navigator.pop(context);
              },
              child: const Text("Add"),
            )

          ],
        );

      },
    );
  }

  void showAddGoalDialog() {

    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {

        return AlertDialog(
          title: const Text("Add Goal"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: "Enter Goal"),
          ),
          actions: [

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {

                String goal = controller.text;

                if (goal.isEmpty) return;

                setState(() {

                  goals.add(goal);

                  for (var friend in friends) {
                    friend["goalStatus"][goal] = false;
                  }

                });

                Navigator.pop(context);

              },
              child: const Text("Save"),
            )

          ],
        );

      },
    );
  }

  void showRemoveGoalDialog() {

    List<String> removableGoals = [];

    for (var goal in goals) {

      bool allCompleted = friends.every(
          (f) => f["goalStatus"][goal] == true);

      if (allCompleted) removableGoals.add(goal);

    }

    showDialog(
      context: context,
      builder: (_) {

        return StatefulBuilder(
          builder: (context, setStateDialog) {

            return AlertDialog(

              title: const Text("Remove Goal"),

              content: DropdownButtonFormField<String>(
                value: goalToRemove,
                hint: const Text("Select Completed Goal"),
                items: removableGoals.map((goal) {

                  return DropdownMenuItem(
                    value: goal,
                    child: Text(goal),
                  );

                }).toList(),
                onChanged: (value) {

                  setStateDialog(() {
                    goalToRemove = value;
                  });

                },
              ),

              actions: [

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        goalToRemove != null ? Colors.red : Colors.grey,
                  ),
                  onPressed: goalToRemove == null
                      ? null
                      : () {

                          setState(() {

                            goals.remove(goalToRemove);

                            for (var friend in friends) {
                              friend["goalStatus"].remove(goalToRemove);
                            }

                            if (selectedGoal == goalToRemove) {
                              selectedGoal =
                                  goals.isNotEmpty ? goals.first : null;
                            }

                            goalToRemove = null;

                          });

                          Navigator.pop(context);

                        },
                  child: const Text("Remove"),
                )

              ],
            );
          },
        );
      },
    );
  }
}