import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:busapp/services/passenger_service.dart';

class PassengerScreen extends StatefulWidget {
  final String busNo;

  const PassengerScreen({super.key, required this.busNo});

  @override
  State<PassengerScreen> createState() => _PassengerScreenState();
}

class _PassengerScreenState extends State<PassengerScreen> {
  LatLng? _busLocation;
  final PassengerService _passengerService = PassengerService();

  @override
  void initState() {
    super.initState();
    _listenToBusLocation();
  }

  void _listenToBusLocation() {
    _passengerService.listenToBus(widget.busNo, (location) {
      final lat = location['latitude'];
      final lng = location['longitude'];

      if (lat != null && lng != null) {
        setState(() {
          _busLocation = LatLng((lat as num).toDouble(), (lng as num).toDouble());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tracking Bus - ${widget.busNo}",
          style: const TextStyle(color: Colors.cyanAccent),
        ),
        backgroundColor: Colors.black87,
        iconTheme: const IconThemeData(color: Colors.cyanAccent),
      ),
      body: _busLocation == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                center: _busLocation,
                zoom: 15.0,
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
                      point: _busLocation!,
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
    );
  }
}
