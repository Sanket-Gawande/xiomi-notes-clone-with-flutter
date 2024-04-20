import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NotesProvider extends ChangeNotifier {
  Box _tasks = Hive.box('notes_box');
  NotesProvider() {
    init();
  }
  List notes = [];

  void init() {
    notes = _tasks.get('notes') ?? [];
  }

  void updateDb() {
    _tasks.put('notes', notes);
    print("Notes updated, ${notes.length} records");
  }

  void addNote(String title, String desc) {
    print('adding...');
    notes.add({"title": title, "desc": desc, "createdAt": DateTime.now()});
    print('pushed to local');
    // notifyListeners();
    updateDb();
    print('updated db');
  }

  void updateNote(int index, String title, String desc) {
    notes[index]["title"] = title;
    notes[index]["desc"] = desc;
    notes[index]["updatedAt"] = DateTime.now();
  }

  void deleteNote(int id) {
// delete id from notes
// delete from box
//  notify change
    notes.removeAt(id);
    notifyListeners();
    updateDb();
  }
}
