import '../../models/trip.dart';

abstract class TripLocalDataSource {
  Future<List<Trip>> getAllTrips();
  Future<Trip?> getTrip(int key);
  Future<Trip> createTrip(Trip trip);
  Future<void> updateTrip(Trip trip);
  Future<void> deleteTrip(int key);
}
