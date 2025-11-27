import 'package:state_notifier/state_notifier.dart';
import 'package:travel_journal/models/trip.dart';
import 'package:travel_journal/models/failure.dart';
import 'package:travel_journal/data/repositories/trip_repository.dart';
import 'package:travel_journal/presentation/state/trip_state.dart';

class TripController extends StateNotifier<TripState> {
  final TripRepository repository;

  TripController({required this.repository}) : super(const TripInitial());

  Future<void> getAllTrips() async {
    state = const TripLoading();
    final result = await repository.getAllTrips();
    state = result.fold(
      (failure) => TripError(failure),
      (trips) => TripSuccess(trips),
    );
  }

  Future<void> getTrip(String id) async {
    state = const TripLoading();
    final result = await repository.getTrip(id);
    state = result.fold(
      (failure) => TripError(failure),
      (trip) => trip == null
          ? TripError(const Failure('Trip not found'))
          : TripSuccess([trip]),
    );
  }

  Future<void> createTrip(Trip trip) async {
    state = const TripLoading();
    final result = await repository.createTrip(trip);
    state = result.fold(
      (failure) => TripError(failure),
      (createdTrip) => TripCreated(createdTrip),
    );
  }

  Future<void> updateTrip(Trip trip) async {
    state = const TripLoading();
    final result = await repository.updateTrip(trip);
    state = result.fold(
      (failure) => TripError(failure),
      (_) => TripUpdated(trip),
    );
  }

  Future<void> deleteTrip(String id) async {
    state = const TripLoading();
    final result = await repository.deleteTrip(id);
    state = result.fold(
      (failure) => TripError(failure),
      (_) => const TripDeleted(),
    );
  }
}