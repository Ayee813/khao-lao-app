import 'package:flutter/material.dart';
import 'package:khao_lao/pages/bottom_navigation_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF016A3D),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                "assets/images/logo.png",
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 5),

              // Welcome Text
              const Text(
                'Welcome to Khao Lao',
                style: TextStyle(
                  color: Color(0xFFFFC65C),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Login Text
              const Text(
                'Login',
                style: TextStyle(
                  color: Color(0xFFFFC65C),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // Username TextField
              Container(
                height: 60, // Set your desired height here
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Username',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15), // Add vertical padding
                    suffixIcon: const Icon(Icons.person_outline),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Password TextField
// Password TextField
              Container(
                height: 60, // Set fixed height to match the username field
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15), // Added vertical padding
                    suffixIcon: const Icon(Icons.visibility_outlined),
                  ),
                ),
              ),
              const SizedBox(height: 30),

// Login Button
              Container(
                height: 60, // Set consistent height for the button
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the bottom navigation page and remove all previous routes
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => BottomNavigationPage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF03BE6D),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Log in',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Sign Up Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Do not have account yet? ',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'SignUp',
                      style: TextStyle(
                        color: Color(0xFFFFC65C),
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
