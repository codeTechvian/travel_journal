import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_journal/models/entry.dart';

class EntriesScreen extends ConsumerWidget {
  const EntriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal Entries'),
        centerTitle: true,
      ),
      body: FutureBuilder<Box<Entry>>(
        future: Hive.openBox<Entry>('entries'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final box = snapshot.data!;
          final entries = box.values.toList().cast<Entry>();

          if (entries.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No entries yet',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tap the + button to add your first entry',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(entry.notes),
                  subtitle: Text(entry.date.toString().split(' ')[0]),
                  trailing: const Text(
                      '>'), // Using text instead of icon to avoid rendering issues
                  onTap: () => _showEntryDetails(context, entry),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewEntry(context, ref),
        child: const Text(
          '+',
          style: TextStyle(
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        tooltip: 'Add New Entry',
      ),
    );
  }

  void _addNewEntry(BuildContext context, WidgetRef ref) {
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Entry'),
          content: TextField(
            controller: notesController,
            decoration: const InputDecoration(
              labelText: 'Notes',
              hintText: 'Write your journal entry here...',
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (notesController.text.trim().isNotEmpty) {
                  final box = await Hive.openBox<Entry>('entries');
                  final entry = Entry(
                    date: DateTime.now(),
                    notes: notesController.text.trim(),
                  );
                  await box.add(entry);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showEntryDetails(BuildContext context, Entry entry) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Entry Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.date.toString().split(' ')[0],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(entry.notes),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
