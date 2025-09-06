import 'package:busapp/BusSearchScreen.dart';
import 'package:flutter/material.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({super.key});

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  bool showLiveUpdate = false;

  String fromLocation = "";
  String toLocation = "";
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001F29), // Dark Teal background
      appBar: AppBar(
        title: const Text("Track My Bus"),
        leading: const Icon(Icons.menu),
        centerTitle: true,
        backgroundColor: const Color(0xFF001F29),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hello Shivam !",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Location Input
              const Text(
                "Enter your Location",
                style: TextStyle(color: Colors.white70),
              ),
              TextField(
                controller: fromController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white10,
                  prefixIcon: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  hintText: "Enter starting point",
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Destination Input
              const Text(
                "Enter your Destination",
                style: TextStyle(color: Colors.white70),
              ),
              TextField(
                controller: toController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white10,
                  prefixIcon: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  hintText: "Enter destination",
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Find Routes Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ).copyWith(
                    backgroundColor: MaterialStateProperty.resolveWith((
                      states,
                    ) {
                      return null; // handled below with gradient
                    }),
                  ),
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
                        const SnackBar(
                          content: Text(
                            "Please enter both From and To locations",
                          ),
                        ),
                      );
                    }
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Find Routes",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // 🌊 Futuristic Bottom Navigation Bar with floating active indicator
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF001F29),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF001F29),
          unselectedItemColor: Colors.white54,
          selectedItemColor: Colors.white,
          showUnselectedLabels: true,
          items: [
            _buildNavItem(Icons.map, "Map", 0),
            _buildNavItem(Icons.directions_bus, "Bus", 1),
            _buildNavItem(Icons.home, "Home", 2),
            _buildNavItem(Icons.search, "Search", 3),
            _buildNavItem(Icons.person, "Profile", 4),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    IconData icon,
    String label,
    int index,
  ) {
    bool isActive = _selectedIndex == index;

    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(6),
        decoration:
            isActive
                ? BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.tealAccent.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                )
                : null,
        child: Icon(icon, color: isActive ? Colors.white : Colors.white54),
      ),
      label: label,
    );
  }
}
