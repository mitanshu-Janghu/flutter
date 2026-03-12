import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
Widget socialLogo(String imagePath) {
  return Container(
    height: 55,
    width: 55,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Image.asset(imagePath),
  );
}
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _formKey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  Widget inputField(String hint, IconData icon, TextEditingController controller,
      String error, {bool passwordField = false}) {

    return TextFormField(
      controller: controller,
      obscureText: passwordField,
      style: const TextStyle(color: Colors.white),

      validator: (value) {
        if (value == null || value.isEmpty) {
          return error;
        }
        return null;
      },

      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white54),
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

  void register() {

    if (_formKey.currentState!.validate()) {

      if (password.text != confirmPassword.text) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Passwords do not match"),
          ),
        );

        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
      );
    }
  }

  Widget socialIcon(IconData icon, Color color) {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color, size: 28),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),

            child: Form(
              key: _formKey,

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

                      Expanded(
                        child: inputField(
                          "First Name",
                          Icons.person,
                          firstName,
                          "Enter first name",
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: inputField(
                          "Last Name",
                          Icons.person,
                          lastName,
                          "Enter last name",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  inputField(
                    "Email",
                    Icons.email,
                    email,
                    "Enter email",
                  ),

                  const SizedBox(height: 15),

                  inputField(
                    "Password",
                    Icons.lock,
                    password,
                    "Enter password",
                    passwordField: true,
                  ),

                  const SizedBox(height: 15),

                  inputField(
                    "Confirm Password",
                    Icons.lock,
                    confirmPassword,
                    "Confirm password",
                    passwordField: true,
                  ),

                  const SizedBox(height: 25),

                  /// REGISTER BUTTON
                  GestureDetector(
                    onTap: register,
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

                  const SizedBox(height: 25),

                  const Text(
                    "Signup using one of the following options",
                    style: TextStyle(color: Colors.white54),
                  ),

                  const SizedBox(height: 20),

                  /// SOCIAL LOGIN ICONS
                  Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [

    socialLogo("assets/images/facebook.jpg"),

    socialLogo("assets/images/google.png"),

    socialLogo("assets/images/apple.png"),

    socialLogo("assets/images/twitter.png"),

  ],
)

                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}