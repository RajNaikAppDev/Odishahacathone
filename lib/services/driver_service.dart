import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';

class DriverService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("buses");
  StreamSubscription<Position>? _positionStream;

  /// Start sending location updates when the bus moves
  Future<void> startUpdatingLocation(String busId) async {
    // Ask for location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permissions permanently denied");
    }

    // Subscribe to location updates (updates only when moved 10 meters)
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // minimum distance in meters to trigger update
      ),
    ).listen((Position position) async {
      await _dbRef.child(busId).set({
        "latitude": position.latitude,
        "longitude": position.longitude,
        "updated_at": DateTime.now().millisecondsSinceEpoch,
      });
    });
  }

  /// Stop sending updates
  void stopUpdatingLocation() {
    _positionStream?.cancel();
    _positionStream = null;
  }
}
