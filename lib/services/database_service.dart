import 'package:hive_flutter/hive_flutter.dart';
import '../models/note.dart';

class DatabaseService {
  static const String _boxName = 'notesBox';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

  Box get _box => Hive.box(_boxName);

  List<Note> getNotes() {
    return _box.values.map((e) {
      final map = Map<String, dynamic>.from(e as Map);
      return Note.fromMap(map);
    }).toList();
  }

  Future<void> addNote(Note note) async {
    final key = DateTime.now().millisecondsSinceEpoch.toString();
    note.id = key;
    await _box.put(key, note.toMap());
  }

  Future<void> updateNote(Note note) async {
    if (note.id != null) {
      await _box.put(note.id, note.toMap());
    }
  }

  Future<void> deleteNote(String id) async {
    await _box.delete(id);
  }
}
