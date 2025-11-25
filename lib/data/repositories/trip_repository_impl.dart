import 'package:dartz/dartz.dart';
import '../../models/trip.dart';
import '../../models/failure.dart';
import '../datasources/trip_local_data_source.dart';
import 'trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDataSource local;

  TripRepositoryImpl({required this.local});

  @override
  Future<Either<Failure, List<Trip>>> getAllTrips() async {
    try {
      final res = await local.getAllTrips();
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Trip?>> getTrip(int key) async {
    try {
      final res = await local.getTrip(key);
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Trip>> createTrip(Trip trip) async {
    try {
      final res = await local.createTrip(trip);
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTrip(Trip trip) async {
    try {
      await local.updateTrip(trip);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTrip(int key) async {
    try {
      await local.deleteTrip(key);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
