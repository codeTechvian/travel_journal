import 'package:hive/hive.dart';
import '../../models/trip.dart';
import 'trip_local_data_source.dart';

class TripLocalDataSourceImpl implements TripLocalDataSource {
  final Box<Trip> box;

  TripLocalDataSourceImpl(this.box);

  @override
  Future<List<Trip>> getAllTrips() async {
    return box.values.toList().cast<Trip>();
  }

  @override
  Future<Trip?> getTrip(String id) async {
    try {
      return box.get(id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Trip> createTrip(Trip trip) async {
    await box.put(trip.id, trip);
    return trip;
  }

  @override
  Future<void> updateTrip(Trip trip) async {
    await box.put(trip.id, trip);
  }

  @override
  Future<void> deleteTrip(String id) async {
    try {
      await box.delete(id);
    } catch (e) {
      // Trip not found, ignore
    }
  }
}
