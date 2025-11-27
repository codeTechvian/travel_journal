import 'package:travel_journal/models/trip.dart';
import 'package:travel_journal/models/failure.dart';

abstract class TripState {
  const TripState();
}

class TripInitial extends TripState {
  const TripInitial();
}

class TripLoading extends TripState {
  const TripLoading();
}

class TripSuccess extends TripState {
  final List<Trip> trips;
  const TripSuccess(this.trips);
}

class TripError extends TripState {
  final Failure failure;
  const TripError(this.failure);
}

class TripCreated extends TripState {
  final Trip trip;
  const TripCreated(this.trip);
}

class TripUpdated extends TripState {
  final Trip trip;
  const TripUpdated(this.trip);
}

class TripDeleted extends TripState {
  const TripDeleted();
}
