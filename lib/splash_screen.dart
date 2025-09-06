import 'package:flutter/material.dart';
import 'package:busapp/Signin_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  static const Color kDeepBlue = Color.fromARGB(255, 135, 8, 198);

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
      backgroundColor: kDeepBlue,
      body: SafeArea(
        child: Stack(
          children: [
            // Subtle road line at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[800]!, Colors.blue[900]!],
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
                                    'assets/images/buslogo-Photoroom.png', // use same logo or small bus icon
                                    height: 50,
                                  ),
                                ),
                                // Location marker
                                Positioned(
                                  right: size.width * 0.25,
                                  top: 0,
                                  child: ScaleTransition(
                                    scale: _markerScaleAnimation,
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.blue[200],
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Bouncing dots
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
                                  color: Colors.blue[200]!.withOpacity(
                                    (DateTime.now().second + index) % 3 == 0
                                        ? 1
                                        : 0.3,
                                  ),
                                  shape: BoxShape.circle,
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
