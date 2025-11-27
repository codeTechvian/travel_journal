import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_journal/models/trip.dart';
import 'package:travel_journal/presentation/providers/trip_providers.dart';
import 'package:travel_journal/presentation/screens/trip_form_screen.dart';
import 'package:travel_journal/presentation/state/trip_state.dart';
import 'package:uuid/uuid.dart';

class TripsScreen extends ConsumerStatefulWidget {
  const TripsScreen({super.key});

  @override
  ConsumerState<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends ConsumerState<TripsScreen> {
  @override
  void initState() {
    super.initState();
    // Load all trips when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(tripControllerProvider).getAllTrips();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tripState = ref.watch(tripControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trips'),
        centerTitle: true,
      ),
      body: _buildTripList(tripState.state), // Access the state property
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTrip,
        child: const Text(
          '+',
          style: TextStyle(
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        tooltip: 'Add New Trip',
      ),
    );
  }

  Widget _buildTripList(TripState tripState) {
    return switch (tripState) {
      TripLoading() => const Center(child: CircularProgressIndicator()),
      TripSuccess(:final trips) => trips.isEmpty
          ? const Center(
              child: Text('No trips yet. Tap + to add your first trip!'),
            )
          : ListView.builder(
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final trip = trips[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(trip.title),
                    subtitle: Text(
                        '${trip.startDate.toString().split(' ')[0]} - ${trip.endDate.toString().split(' ')[0]}'),
                    trailing: const Text(
                        '>'), // Using text instead of icon to avoid rendering issues
                    onTap: () => _navigateToEditTrip(trip),
                  ),
                );
              },
            ),
      TripError(:final failure) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: ${failure.message}'),
              ElevatedButton(
                onPressed: () => ref.read(tripControllerProvider).getAllTrips(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      TripCreated(:final trip) || TripUpdated(:final trip) => _buildTripList(
          TripSuccess([trip]),
        ),
      TripDeleted() => const Center(
          child: Text('Trip deleted successfully'),
        ),
      _ => const Center(
          child: Text('Trips will be displayed here'),
        ),
    };
  }

  void _navigateToAddTrip() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripFormScreen(
          trip: Trip(
            id: const Uuid().v4(),
            title: '',
            startDate: DateTime.now(),
            endDate: DateTime.now().add(const Duration(days: 1)),
            description: '',
          ),
        ),
      ),
    ).then((_) {
      // Refresh the trips list when returning from the form
      ref.read(tripControllerProvider).getAllTrips();
    });
  }

  void _navigateToEditTrip(Trip trip) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripFormScreen(
          trip: trip,
        ),
      ),
    ).then((_) {
      // Refresh the trips list when returning from the form
      ref.read(tripControllerProvider).getAllTrips();
    });
  }
}
