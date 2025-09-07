import 'package:busapp/conductorPage.dart';
import 'package:busapp/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:busapp/Signin_page.dart';
import 'package:flutter/services.dart'; // 👈 add this at the top

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;
  String? _selectedUserType;

  final List<String> _userTypes = ['Passenger', 'Driver', 'Conductor'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // let gradient show
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app, color: Colors.cyanAccent),
          onPressed: () {
            SystemNavigator.pop();
          },
        ),
        title: const Text(
          "Login Screen",
          style: TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity, // ✅ full width
        height: double.infinity, // ✅ full height
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0f2027), // dark navy
              Color(0xFF203a43), // deep blue
              Color(0xFF2c5364), // teal-blue blend
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Welcome text
                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 20,
                            color: Colors.blueAccent,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Dropdown for user type
                    SizedBox(
                      width: 300,
                      child: DropdownButtonFormField<String>(
                        dropdownColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: "Select User Type",
                          labelStyle: const TextStyle(color: Colors.cyanAccent),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.cyanAccent,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blueAccent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        value: _selectedUserType,
                        items:
                            _userTypes
                                .map(
                                  (type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(
                                      type,
                                      style: const TextStyle(
                                        color: Colors.cyanAccent,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedUserType = value;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Email + Password
                    SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              label: const Text(
                                "Email",
                                style: TextStyle(color: Colors.cyanAccent),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.cyanAccent,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          TextFormField(
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              label: const Text(
                                "Password",
                                style: TextStyle(color: Colors.cyanAccent),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.cyanAccent,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Remember me
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          activeColor: Colors.cyanAccent,
                          checkColor: Colors.black,
                          onChanged: (bool? value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                          shape: const CircleBorder(),
                        ),
                        const Text(
                          "Remember me",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Sign In Button
                    SizedBox(
                      height: 55,
                      width: 320,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_selectedUserType == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please select a user type first",
                                ),
                              ),
                            );
                            return;
                          }

                          if (_selectedUserType == "Passenger") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TrackScreen(),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Conductorpage(),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          side: const BorderSide(
                            color: Colors.cyanAccent,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          shadowColor: Colors.blueAccent,
                          elevation: 10,
                        ),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.cyanAccent,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 15,
                                color: Colors.blueAccent,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Create account
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: "Create Account",
                            style: const TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                const CreateAccountScreen(),
                                      ),
                                    );
                                  },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
