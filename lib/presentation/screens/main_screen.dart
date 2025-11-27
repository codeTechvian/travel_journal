import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_journal/presentation/screens/home_screen.dart';
import 'package:travel_journal/presentation/screens/trips_screen.dart';
import 'package:travel_journal/presentation/screens/entries_screen.dart';
import 'package:travel_journal/presentation/screens/profile_screen.dart';
import 'package:travel_journal/presentation/screens/more_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _currentIndex = 0;

  // Screens for each tab
  final List<Widget> _screens = [
    const HomeScreen(),
    const TripsScreen(),
    const EntriesScreen(),
    const ProfileScreen(),
    const MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Text('🏠'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Text('✈️'),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Text('📝'),
            label: 'Entries',
          ),
          BottomNavigationBarItem(
            icon: Text('👤'),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Text('⋯'),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
