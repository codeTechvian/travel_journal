import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:travel_journal/models/trip.dart';
import 'package:travel_journal/data/datasources/trip_local_data_source_impl.dart';
import 'package:travel_journal/data/repositories/trip_repository.dart';
import 'package:travel_journal/data/repositories/trip_repository_impl.dart';
import 'package:travel_journal/presentation/controller/trip_controller.dart';

// Hive box provider
final tripBoxProvider = Provider<Box<Trip>>((ref) {
  return Hive.box<Trip>('trips');
});

// Data source provider
final tripLocalDataSourceProvider = Provider((ref) {
  final box = ref.watch(tripBoxProvider);
  return TripLocalDataSourceImpl(box);
});

// Repository provider
final tripRepositoryProvider = Provider<TripRepository>((ref) {
  final local = ref.watch(tripLocalDataSourceProvider);
  return TripRepositoryImpl(local: local);
});

// Controller provider
final tripControllerProvider = Provider<TripController>((ref) {
  final repo = ref.watch(tripRepositoryProvider);
  return TripController(repository: repo);
});