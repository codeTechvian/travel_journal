import 'package:dartz/dartz.dart';
import '../../models/trip.dart';
import '../../models/failure.dart';

abstract class TripRepository {
  Future<Either<Failure, List<Trip>>> getAllTrips();
  Future<Either<Failure, Trip?>> getTrip(int key);
  Future<Either<Failure, Trip>> createTrip(Trip trip);
  Future<Either<Failure, void>> updateTrip(Trip trip);
  Future<Either<Failure, void>> deleteTrip(int key);
}
