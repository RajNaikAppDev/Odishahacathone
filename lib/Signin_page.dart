import 'package:busapp/login_scren.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background gradient with dark neon vibe
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                // Title
                Center(
                  child: Text(
                    "Create an Account",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyanAccent.shade200,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.cyanAccent.shade200,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Glassmorphism container for form
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.cyanAccent.shade200.withOpacity(0.4),
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          // Email
                          _buildGlassTextField(
                            controller: emailController,
                            hint: "Username or Email",
                            icon: Icons.person,
                          ),
                          const SizedBox(height: 20),
                          // Password
                          _buildGlassTextField(
                            controller: passwordController,
                            hint: "Password",
                            icon: Icons.lock,
                            obscureText: true,
                          ),
                          const SizedBox(height: 20),
                          // Confirm Password
                          _buildGlassTextField(
                            controller: confirmPasswordController,
                            hint: "Confirm Password",
                            icon: Icons.lock_outline,
                            obscureText: true,
                          ),
                          const SizedBox(height: 30),
                          // Create Account Button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyanAccent.shade400
                                    .withOpacity(0.6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                shadowColor: Colors.cyanAccent,
                                elevation: 10,
                              ),
                              onPressed: () {
                                // Handle signup logic
                              },
                              child: const Text(
                                "Create Account",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "-Or continue with-",
                            style: TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 20),
                          // Social buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildSocialButton(
                                "https://img.icons8.com/color/48/google-logo.png",
                              ),
                              const SizedBox(width: 20),
                              _buildSocialButton(
                                "https://img.icons8.com/ios-filled/50/facebook-new.png",
                              ),
                              const SizedBox(width: 20),
                              _buildSocialButton(
                                "https://img.icons8.com/ios-filled/50/mac-os.png",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                // Already have an account
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "I Already have an Account ",
                        style: TextStyle(color: Colors.white70),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.cyanAccent.shade200,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 8,
                                color: Colors.cyanAccent.shade200,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                        ),
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
    );
  }

  // Glass TextField builder
  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.cyanAccent.shade200.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.cyanAccent.shade200),
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white70),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Social button builder
  Widget _buildSocialButton(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.05),
        border: Border.all(
          color: Colors.cyanAccent.shade200.withOpacity(0.4),
          width: 1.2,
        ),
      ),
      child: IconButton(
        icon: Image.network(imageUrl),
        iconSize: 40,
        onPressed: () {},
      ),
    );
  }
}
