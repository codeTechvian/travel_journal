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
  Future<Trip?> getTrip(int key) async {
    return box.get(key);
  }

  @override
  Future<Trip> createTrip(Trip trip) async {
    final key = await box.add(trip);
    return box.get(key)!;
  }

  @override
  Future<void> updateTrip(Trip trip) async {
    await trip.save();
  }

  @override
  Future<void> deleteTrip(int key) async {
    await box.delete(key);
  }
}
