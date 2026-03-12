import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  Widget buildTextField(String hint, IconData icon) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white70),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xFF1A1A1A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget socialButton(String asset) {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Image.asset(asset),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [

              const SizedBox(height: 40),

              const Text(
                "Signup",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              Row(
                children: [
                  Expanded(child: buildTextField("First Name", Icons.person)),
                  const SizedBox(width: 10),
                  Expanded(child: buildTextField("Last Name", Icons.person)),
                ],
              ),

              const SizedBox(height: 15),

              buildTextField("Email", Icons.email),

              const SizedBox(height: 15),

              buildTextField("Password", Icons.lock),

              const SizedBox(height: 15),

              buildTextField("Confirm Password", Icons.lock),

              const SizedBox(height: 25),

              /// REGISTER BUTTON
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardScreen(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Signup using one of the following options",
                style: TextStyle(color: Colors.white54),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  socialButton("assets/images/facebook.jpg"),
                  socialButton("assets/images/google.png"),
                  socialButton("assets/images/apple.png"),
                  socialButton("assets/images/twitter.png"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}