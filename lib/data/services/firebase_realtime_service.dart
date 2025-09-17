import 'package:firebase_database/firebase_database.dart';
import 'package:inventi/data/models/location_model.dart';
import 'dart:developer' as developer;

class FirebaseRealtimeDatabaseService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();
  Stream<List<LocationModel>> listenToLocations() {
    return _db.child('locations').onValue.map((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);

      final List<LocationModel> locations = [];

      data.forEach((key, value) {
        locations.add(LocationModel.fromJson(Map<String, dynamic>.from(value)));
      });
      developer.log('Locations updated: $locations');
      return locations;
    });
  }
}
