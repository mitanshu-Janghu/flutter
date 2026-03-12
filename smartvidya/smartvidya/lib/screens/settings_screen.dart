import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool darkMode = true;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Settings"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            SwitchListTile(
              title: const Text(
                "Dark Mode",
                style: TextStyle(color: Colors.white),
              ),
              value: darkMode,
              activeThumbColor: Colors.green,
              onChanged: (value) {
                setState(() {
                  darkMode = value;
                });
              },
            ),

            const Divider(color: Colors.white12),

            SwitchListTile(
              title: const Text(
                "Notifications",
                style: TextStyle(color: Colors.white),
              ),
              value: notifications,
              activeThumbColor: Colors.green,
              onChanged: (value) {
                setState(() {
                  notifications = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}