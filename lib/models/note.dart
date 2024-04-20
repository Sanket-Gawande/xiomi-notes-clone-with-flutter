import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 2)
class Note {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? desc;

  @HiveField(2)
  DateTime createdAt = DateTime.timestamp();

  @HiveField(3)
  DateTime? UpdatedAt;

  Note({required this.title, required this.desc, this.UpdatedAt}) {}
}