import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:busapp/services/passenger_service.dart';

import 'screens/passenger_screen.dart'; // Make sure this import points to your PassengerScreen

class BusSearchScreen extends StatelessWidget {
  final String fromLocation;
  final String toLocation;

  const BusSearchScreen({
    super.key,
    required this.fromLocation,
    required this.toLocation,
  });

  @override
  Widget build(BuildContext context) {
    // Sample bus data
    List<Map<String, String>> buses = [
      {"busNo": "GA 1245", "duration": "2 mins", "nextTrip": "12:00 AM"},
      {"busNo": "GA 1255", "duration": "3 mins", "nextTrip": "12:15 AM"},
      {"busNo": "GA 1265", "duration": "5 mins", "nextTrip": "12:30 AM"},
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.cyanAccent),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Bus Search",
          style: TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Routes Found (${buses.length}) 🚍",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent.shade200,
                shadows: [
                  Shadow(blurRadius: 10, color: Colors.cyanAccent.shade200),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "From: $fromLocation 📍\nTo: $toLocation 📍",
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Bus list with neon style
            Expanded(
              child: ListView.builder(
                itemCount: buses.length,
                itemBuilder: (context, index) {
                  final bus = buses[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.cyanAccent.shade100.withOpacity(0.4),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bus ${index + 1} → ${bus["busNo"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyanAccent.shade100,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Duration: ${bus["duration"]}",
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Text(
                              "Next Trip: ${bus["nextTrip"]}",
                              style: const TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(height: 10),

                            // Track Live Button
                            Center(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyanAccent.shade400
                                      .withOpacity(0.6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  shadowColor: Colors.cyanAccent,
                                  elevation: 8,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PassengerScreen(
                                        busNo: bus["busNo"]!,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.fiber_manual_record,
                                  color: Colors.redAccent,
                                ),
                                label: const Text(
                                  "TRACK LIVE",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Neon bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black.withOpacity(0.6),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.white70,
        items: const [
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
