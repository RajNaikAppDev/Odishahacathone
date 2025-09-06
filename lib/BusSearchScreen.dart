import 'package:flutter/material.dart';

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
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Bus Search"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Routes Found (${buses.length})..",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "From : $fromLocation  📍\nTo : $toLocation  📍",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

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
                    margin: EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bus ${index + 1} No : ${bus["busNo"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text("Duration : ${bus["duration"]}"),
                          Text("Next Trip : ${bus["nextTrip"]}"),
                          SizedBox(height: 10),

                          // Track Live Button
                          Center(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                              ),
                              onPressed: () {
                                // TODO: Add navigation to Live Tracking Page
                              },
                              icon: Icon(
                                Icons.fiber_manual_record,
                                color: Colors.red,
                              ),
                              label: Text("TRACK LIVE"),
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
