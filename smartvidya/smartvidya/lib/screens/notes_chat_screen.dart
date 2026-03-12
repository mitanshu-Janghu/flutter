import 'package:flutter/material.dart';

class NotesChatScreen extends StatefulWidget {
  const NotesChatScreen({super.key});

  @override
  State<NotesChatScreen> createState() => _NotesChatScreenState();
}

class _NotesChatScreenState extends State<NotesChatScreen> {

  final TextEditingController controller = TextEditingController();

  List<Map<String, String>> messages = [];

  void sendMessage() {

    if (controller.text.isEmpty) return;

    setState(() {
      messages.add({
        "role": "user",
        "text": controller.text
      });

      messages.add({
        "role": "bot",
        "text": "Generated notes for: ${controller.text}"
      });
    });

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Notes Generator"),
      ),

      body: Column(
        children: [

          /// CHAT AREA
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {

                bool isUser = messages[index]["role"] == "user";

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser
                          ? Colors.green
                          : const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      messages[index]["text"]!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),

          /// INPUT AREA
          Container(
            padding: const EdgeInsets.all(10),
            color: const Color(0xFF1A1A1A),
            child: Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Ask for notes...",
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.send, color: Colors.green),
                  onPressed: sendMessage,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}