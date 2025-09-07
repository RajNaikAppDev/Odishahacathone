import 'package:flutter/material.dart';
import 'package:busapp/Signin_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  static const Color kBackground = Color(0xFF0B0C10);
  static const Color kNeonPrimary = Color(0xFF00C6FF);
  static const Color kNeonSecondary = Color(0xFF0072FF);
  static const Color kNeonAccent = Color(0xFF00E0FF);

  late final AnimationController _busController;
  late final Animation<Offset> _busAnimation;

  late final AnimationController _logoController;
  late final Animation<double> _logoAnimation;

  late final AnimationController _markerController;
  late final Animation<double> _markerScaleAnimation;

  @override
  void initState() {
    super.initState();

    // Bus moving animation
    _busController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _busAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: const Offset(1.5, 0),
    ).animate(CurvedAnimation(parent: _busController, curve: Curves.easeInOut));
    _busController.repeat(reverse: true);

    // Logo fade-in animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _logoAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(seconds: 2), () {
      _logoController.forward();
    });

    // Location marker pulsing animation
    _markerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _markerScaleAnimation = Tween<double>(begin: 1, end: 1.3).animate(
      CurvedAnimation(parent: _markerController, curve: Curves.easeInOut),
    );

    // Navigate after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CreateAccountScreen()),
      );
    });
  }

  @override
  void dispose() {
    _busController.dispose();
    _logoController.dispose();
    _markerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Stack(
          children: [
            // Subtle neon road line at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kNeonPrimary, kNeonSecondary],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Logo
                          Hero(
                            tag: 'busbuddy-logo',
                            child: FadeTransition(
                              opacity: _logoAnimation,
                              child: Image.asset(
                                'assets/images/buslogo-Photoroom.png',
                                height: size.height * 0.3,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Moving bus animation
                          SizedBox(
                            height: 50,
                            width: size.width,
                            child: Stack(
                              children: [
                                SlideTransition(
                                  position: _busAnimation,
                                  child: Image.asset(
                                    'assets/images/buslogo-Photoroom.png',
                                    height: 50,
                                  ),
                                ),
                                // Location marker with glow
                                Positioned(
                                  right: size.width * 0.25,
                                  top: 0,
                                  child: ScaleTransition(
                                    scale: _markerScaleAnimation,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: kNeonAccent.withOpacity(0.6),
                                            blurRadius: 20,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.location_on,
                                        color: kNeonAccent,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Bouncing neon dots
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (index) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kNeonAccent.withOpacity(
                                    (DateTime.now().second + index) % 3 == 0
                                        ? 1
                                        : 0.3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: kNeonAccent.withOpacity(0.6),
                                      blurRadius: 12,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
