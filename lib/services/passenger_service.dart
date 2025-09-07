import 'package:firebase_database/firebase_database.dart';

class PassengerService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("buses");

  // Listen to updates for a specific bus
  void listenToBus(
    String busId,
    void Function(Map<String, dynamic> location) onUpdate,
  ) {
    _dbRef.child(busId).onValue.listen((event) {
      final value = event.snapshot.value;
      if (value != null && value is Map) {
        onUpdate(Map<String, dynamic>.from(value));
      }
    });
  }
}
