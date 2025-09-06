import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
      {"busNo": "GA 1255", "duration": "2 mins", "nextTrip": "12:00 AM"},
      {"busNo": "GA 1265", "duration": "2 mins", "nextTrip": "12:00 AM"},
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Bus Search"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Routes Found (${buses.length})..",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "From : $fromLocation  📍\nTo : $toLocation  📍",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Bus list
            Expanded(
              child: ListView.builder(
                itemCount: buses.length,
                itemBuilder: (context, index) {
                  final bus = buses[index];
                  return Card(
                    color: Colors.blue[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bus ${index + 1} No : ${bus["busNo"]}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text("Duration : ${bus["duration"]}"),
                          Text("Next Trip : ${bus["nextTrip"]}"),
                          const SizedBox(height: 10),

                          // Track Live Button
                          Center(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                              ),
                              onPressed: () {
                                // ✅ Navigate to map page
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
                                color: Colors.red,
                              ),
                              label: const Text("TRACK LIVE"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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

/// ✅ New screen with OpenStreetMap
class LiveMapScreen extends StatelessWidget {
  final String busNo;

  const LiveMapScreen({super.key, required this.busNo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Tracking - $busNo"),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(28.6139, 77.2090), // Sample center (Delhi)
          zoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.busapp',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(28.6139, 77.2090),
                width: 80,
                height: 80,
                builder: (ctx) => const Icon(
                  Icons.directions_bus,
                  color: Colors.green,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
