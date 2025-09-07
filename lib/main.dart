// import 'package:busapp/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';

// void main() async {
//   // Ensure Flutter engine is initialized
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize Firebase before running the app
//   await Firebase.initializeApp();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(), // ✅ Your splash screen remains the entry point
//     );
//   }
// }
import 'package:busapp/screens/driver_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DriverScreen(busId: "GA1245"), // test with one bus
    );
  }
}
