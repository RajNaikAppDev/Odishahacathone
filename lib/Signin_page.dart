import 'package:busapp/login_scren.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController favoriteRouteController = TextEditingController();
  final TextEditingController busNumberController = TextEditingController();
  final TextEditingController conductorIdController = TextEditingController();

  String selectedRole = "Passenger"; // default

  final List<Color> _gradientColors = const [
    Color(0xFF0f2027), // dark navy
    Color(0xFF203a43), // deep blue
    Color(0xFF2c5364), // teal-blue blend
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
          "Signup",
          style: TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _gradientColors,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Create an Account",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyanAccent,
                      shadows: [
                        Shadow(
                          blurRadius: 20,
                          color: Colors.blueAccent,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Role Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label: const Text("Passenger"),
                        selected: selectedRole == "Passenger",
                        selectedColor: Colors.cyanAccent,
                        onSelected: (val) {
                          setState(() => selectedRole = "Passenger");
                        },
                        labelStyle: TextStyle(
                          color:
                              selectedRole == "Passenger"
                                  ? Colors.black
                                  : const Color.fromARGB(179, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ChoiceChip(
                        label: const Text("Conductor"),
                        selected: selectedRole == "Conductor",
                        selectedColor: Colors.cyanAccent,
                        onSelected: (val) {
                          setState(() => selectedRole = "Conductor");
                        },
                        labelStyle: TextStyle(
                          color:
                              selectedRole == "Conductor"
                                  ? Colors.black
                                  : const Color.fromARGB(179, 2, 2, 2),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Common Fields
                  _buildTextField(
                    controller: fullNameController,
                    hint: "Full Name",
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: emailController,
                    hint: "Email or Phone",
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: passwordController,
                    hint: "Password",
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: confirmPasswordController,
                    hint: "Confirm Password",
                    icon: Icons.lock_outline,
                    obscureText: true,
                  ),

                  const SizedBox(height: 20),

                  // Passenger-only field
                  if (selectedRole == "Passenger")
                    _buildTextField(
                      controller: favoriteRouteController,
                      hint: "Favorite Routes / Stops (optional)",
                      icon: Icons.directions_bus,
                    ),

                  // Conductor-only fields
                  if (selectedRole == "Conductor") ...[
                    _buildTextField(
                      controller: busNumberController,
                      hint: "Bus Number / Route ID",
                      icon: Icons.directions,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: conductorIdController,
                      hint: "Employee / Conductor ID (optional)",
                      icon: Icons.badge,
                    ),
                  ],

                  const SizedBox(height: 30),

                  // Register Button
                  SizedBox(
                    height: 55,
                    width: 320,
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedRole == "Passenger") {
                          // TODO: Handle passenger signup
                        } else {
                          // TODO: Handle conductor signup
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
                      child: Text(
                        selectedRole == "Passenger"
                            ? "Register as Passenger"
                            : "Register as Conductor",
                        style: const TextStyle(
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

                  // Already have account
                  RichText(
                    text: TextSpan(
                      text: "I already have an account ",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: "Login",
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
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.cyanAccent),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.cyanAccent),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
