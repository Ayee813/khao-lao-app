import 'package:flutter/material.dart';
import 'package:khao_lao/pages/bottom_navigation_page.dart';
import 'package:khao_lao/pages/sign_up_page.dart';
import 'package:khao_lao/pages/sign_up_page.dart'; // Import the signup page

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF016A3D),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    "assets/images/logo.png",
                    height: 120, // Reduced size
                    width: 120,
                  ),
                  const SizedBox(height: 5),

                  // Welcome Text
                  const Text(
                    'Welcome to Khao Lao',
                    style: TextStyle(
                      color: Color(0xFFFFC65C),
                      fontSize: 24, // Reduced size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8), // Reduced spacing

                  // Login Text
                  const Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xFFFFC65C),
                      fontSize: 20, // Reduced size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20), // Reduced spacing

                  // Username TextField
                  SizedBox(
                    height: 50, // Reduced height
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(fontSize: 14),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25), // Slightly smaller radius
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12), // Reduced padding
                        suffixIcon: const Icon(Icons.person_outline, size: 20), // Smaller icon
                      ),
                    ),
                  ),
                  const SizedBox(height: 12), // Reduced spacing

                  // Password TextField
                  SizedBox(
                    height: 50, // Reduced height
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(fontSize: 14),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25), // Slightly smaller radius
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12), // Reduced padding
                        suffixIcon: const Icon(Icons.visibility_outlined, size: 20), // Smaller icon
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Reduced spacing

                  // Login Button
                  SizedBox(
                    height: 48, // Reduced height
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
                        padding: const EdgeInsets.symmetric(vertical: 12), // Reduced padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25), // Slightly smaller radius
                        ),
                      ),
                      child: const Text(
                        'Log in',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // Sign Up Text with Navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Do not have account yet? ',
                        style: TextStyle(color: Colors.white, fontSize: 14), // Reduced size
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to the SignupPage
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SignupPage()),
                          );
                        },
                        child: const Text(
                          'SignUp',
                          style: TextStyle(
                              color: Color(0xFFFFC65C),
                              fontWeight: FontWeight.bold,
                              fontSize: 14), // Reduced size
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}