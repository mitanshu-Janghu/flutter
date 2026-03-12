import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import 'ai_chat_screen.dart';
import 'notes_chat_screen.dart';
import 'reading_support_screen.dart';
import 'profile_screen.dart';
import 'class_screen.dart';
import 'analytics_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  bool notesGenerated = false;
  bool quizAvailable = false;
  bool autoMode = true;
  int _selectedIndex = 0;

  /// TOGGLE AUTO MODE
  void toggleAutoMode() {
    setState(() {
      autoMode = !autoMode;
    });
  }

  /// NAVIGATION TAP
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// GET CURRENT DATE
  String getCurrentDate() {
    DateTime now = DateTime.now();

    List months = [
      "January","February","March","April","May","June",
      "July","August","September","October","November","December"
    ];

    return "${months[now.month - 1]} ${now.day}";
  }

  /// QUICK ACTION TILE
  Widget actionTile(String title, String subtitle, IconData icon, VoidCallback? action) {
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

  /// DASHBOARD HOME PAGE
  Widget homePage() {

    String today = getCurrentDate();

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 20),

              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Active",
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),

                  Text(
                    today,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.camera_alt, color: Colors.white),
                  )
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                "Quick actions",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              /// NOTES
              actionTile(
                "Generate study notes",
                "Tap to open notes generator",
                Icons.menu_book,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotesChatScreen(),
                    ),
                  );
                },
              ),

              /// QUIZ
              actionTile(
                "Launch mini-quiz",
                "Start quick knowledge test",
                Icons.quiz,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuizScreen(),
                    ),
                  );
                },
              ),

              /// EXPLANATION
              actionTile(
                "Provide simpler explanation",
                "AI explanation",
                Icons.flash_on,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AIChatScreen(
                        title: "AI Explanation",
                      ),
                    ),
                  );
                },
              ),

              /// READING SUPPORT
              actionTile(
                "1:1 reading support",
                "Reading assistant",
                Icons.record_voice_over,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReadingSupportScreen(),
                    ),
                  );
                },
              ),

              /// AUTO MODE
              actionTile(
                autoMode ? "Auto mode ON" : "Auto mode OFF",
                "Tap to toggle",
                autoMode ? Icons.toggle_on : Icons.toggle_off,
                toggleAutoMode,
              ),

              /// SETTINGS
              actionTile(
                "Sensitivity: medium",
                "Latency mode: low-power",
                Icons.settings,
                () {},
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    /// PAGES FOR NAVIGATION
final List<Widget> pages = [
  homePage(),
  const AnalyticsScreen(),
  const ClassScreen(),
  const ProfileScreen(),
]; 
return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      body: pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1A1A1A),
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white54,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: "Analytics"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Class"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}