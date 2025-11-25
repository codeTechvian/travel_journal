import 'package:hive/hive.dart';

part 'entry.g.dart';

@HiveType(typeId: 1)
class Entry extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  String notes;

  Entry({required this.date, required this.notes});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Entry &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          notes == other.notes;

  @override
  int get hashCode => Object.hash(date, notes);
}
