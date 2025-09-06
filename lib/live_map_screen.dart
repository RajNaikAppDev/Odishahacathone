import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LiveMapScreen extends StatelessWidget {
  final String busNo;

  const LiveMapScreen({super.key, required this.busNo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Live Tracking - $busNo",
          style: const TextStyle(color: Colors.cyanAccent),
        ),
        backgroundColor: Colors.black87,
        iconTheme: const IconThemeData(color: Colors.cyanAccent),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FlutterMap(
          options: const MapOptions(
            center: LatLng(28.6139, 77.2090),
            zoom: 13.0,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              userAgentPackageName: 'com.example.busapp',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: const LatLng(28.6139, 77.2090),
                  width: 80,
                  height: 80,
                  child: const Icon(
                    Icons.directions_bus,
                    color: Colors.cyanAccent,
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
