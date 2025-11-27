import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:travel_journal/core/hive_registry.dart';
import 'package:travel_journal/core/theme.dart';
import 'package:travel_journal/models/trip.dart';
import 'package:travel_journal/models/entry.dart';
import 'package:travel_journal/presentation/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await registerHiveAdapters();

  // Open Hive boxes
  await Hive.openBox<Trip>('trips');
  await Hive.openBox<Entry>('entries');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Travel Journal',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainScreen(),
    );
  }
}
