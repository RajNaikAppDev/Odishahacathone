import 'package:busapp/BusSearchScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  bool showLiveUpdate = false;

  String fromLocation = "";
  String toLocation = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track My Bus"),
        leading: Icon(Icons.menu),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello Shivam !",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Location Input
              Text("Enter your Location"),
              TextField(
                controller: fromController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  hintText: "Enter starting point",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Destination Input
              Text("Enter your Destination"),
              TextField(
                controller: toController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  hintText: "Enter destination",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Find Routes Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    String fromLocation = fromController.text;
                    String toLocation = toController.text;

                    if (fromLocation.isNotEmpty && toLocation.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => BusSearchScreen(
                                fromLocation: fromLocation,
                                toLocation: toLocation,
                              ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Please enter both From and To locations",
                          ),
                        ),
                      );
                    }
                  },

                  child: Text("Find Routes"),
                ),
              ),

              SizedBox(height: 20),

              // Show entered locations
              if (fromLocation.isNotEmpty && toLocation.isNotEmpty)
                Text(
                  "Route: $fromLocation ➝ $toLocation",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

              SizedBox(height: 20),

              // Live Update Section
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus),
            label: "Bus",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
