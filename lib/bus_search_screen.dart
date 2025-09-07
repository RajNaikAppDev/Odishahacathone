import 'dart:ui';
import 'package:flutter/material.dart';
import 'live_map_screen.dart';

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
          icon: const Icon(Icons.arrow_back, color: Colors.deepPurpleAccent),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Bus Search",
          style: TextStyle(
            color: Colors.deepPurpleAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A1F4A), Color(0xFF3F2B96), Color(0xFF5F4B8B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedOpacity(
              opacity: 1,
              duration: const Duration(milliseconds: 800),
              child: Text(
                "Routes Found (${buses.length}) 🚍",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purpleAccent.shade100,
                  shadows: [
                    Shadow(
                      blurRadius: 12,
                      color: Colors.purpleAccent.shade100,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "From: $fromLocation 📍\nTo: $toLocation 📍",
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: buses.length,
                itemBuilder: (context, index) {
                  final bus = buses[index];
                  return TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: Duration(milliseconds: 500 + index * 100),
                    builder: (context, value, child) => Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, (1 - value) * 20),
                        child: child,
                      ),
                    ),
                    child: ClipRRect(
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
                              color: Colors.purpleAccent.withOpacity(0.4),
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
                                  color: Colors.purpleAccent.shade100,
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
                              Center(
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurpleAccent
                                        .withOpacity(0.6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    shadowColor: Colors.purpleAccent,
                                    elevation: 10,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LiveMapScreen(
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
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
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

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1F4A), Color(0xFF3F2B96)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purpleAccent.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.purpleAccent,
          unselectedItemColor: Colors.white70,
          showUnselectedLabels: false,
          onTap: (index) {
            // TODO: implement navigation
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: "Map",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_bus),
              label: "Bus",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}