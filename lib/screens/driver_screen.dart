import 'package:flutter/material.dart';
import '../services/driver_service.dart';

class DriverScreen extends StatefulWidget {
  final String busId; // unique bus ID

  const DriverScreen({
    super.key,
    required this.busId,
    required String name,
    required String email,
    required String busNumber,
    required String busRoutes,
  });

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  final DriverService _driverService = DriverService();
  bool _isTracking = false;

  void _toggleTracking() async {
    if (_isTracking) {
      _driverService.stopUpdatingLocation();
    } else {
      await _driverService.startUpdatingLocation(widget.busId);
    }
    setState(() {
      _isTracking = !_isTracking;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Panel - Bus ${widget.busId}"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _toggleTracking,
          child: Text(
            _isTracking ? "Stop Sharing Location" : "Start Sharing Location",
          ),
        ),
      ),
    );
  }
}
