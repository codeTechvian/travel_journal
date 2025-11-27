import 'package:hive/hive.dart';
import 'package:travel_journal/models/trip.dart';
import 'package:travel_journal/models/entry.dart';

Future<void> registerHiveAdapters() async {
  if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(TripAdapter());
  if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(EntryAdapter());
}
