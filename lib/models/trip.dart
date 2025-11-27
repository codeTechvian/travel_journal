import 'package:hive/hive.dart';
import 'entry.dart';

part 'trip.g.dart'; // MUST BE HERE

@HiveType(typeId: 0)
class Trip extends HiveObject {
  @HiveField(0)
  String id; // UNIQUE ID for CRUD

  @HiveField(1)
  String title;

  @HiveField(2)
  DateTime startDate;

  @HiveField(3)
  DateTime endDate;

  @HiveField(4)
  String description;

  @HiveField(5)
  List<Entry> entries;

  Trip({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.description,
    List<Entry>? entries,
  }) : entries = entries ?? [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Trip &&
          id == other.id &&
          title == other.title &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          description == other.description &&
          _entryListEquals(entries, other.entries);

  static bool _entryListEquals(List<Entry> a, List<Entry> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    startDate,
    endDate,
    description,
    Object.hashAll(entries),
  );
}
