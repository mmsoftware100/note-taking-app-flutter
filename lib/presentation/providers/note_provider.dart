import 'package:flutter/material.dart';
import '../../domain/entities/Note.dart';

class NoteProvider with ChangeNotifier {
  final List<Note> _notes = [];

  NoteProvider() {
    _initializeDefaults();
  }

  List<Note> get noteList => _notes;

  void _initializeDefaults() {
    _notes.addAll([
      Note(id: '1', title: 'Welcome', content: 'This is your first note!'),
      Note(id: '2', title: 'Groceries', content: 'Milk, Eggs, Bread'),
      Note(id: '3', title: 'Todo', content: 'Finish Flutter app'),
      Note(id: '4', title: 'Ideas', content: 'Build a habit tracker'),
      Note(id: '5', title: 'Quotes', content: '“Stay hungry, stay foolish.”'),
    ]);
  }

  void addNote(String title, String content) {
    final note = Note(
      id: DateTime.now().toString(),
      title: title,
      content: content,
    );
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(String id, String title, String content) {
    final index = _notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      _notes[index].title = title;
      _notes[index].content = content;
      notifyListeners();
    }
  }

  Note? getNoteById(String id) {
    return _notes.firstWhere(
          (note) => note.id == id,
      orElse: () => Note(id: '', title: '', content: ''),
    );
  }
}
