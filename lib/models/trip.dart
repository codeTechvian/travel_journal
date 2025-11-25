import 'package:hive/hive.dart';
import 'entry.dart';

part 'trip.g.dart';

@HiveType(typeId: 0)
class Trip extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  DateTime startDate;

  @HiveField(2)
  DateTime endDate;

  @HiveField(3)
  String description;

  @HiveField(4)
  List<Entry> entries;

  Trip({
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
    title,
    startDate,
    endDate,
    description,
    Object.hashAll(entries),
  );
}
