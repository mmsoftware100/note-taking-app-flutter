import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/api_service.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes => _notes;

  Future<void> fetchNotes() async {
    final response = await ApiService.getNotes();
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      _notes = data.map((e) => Note.fromJson(e)).toList();
      notifyListeners();
    }
  }

  Future<void> addNote(String title, String description, String date) async {
    final response = await ApiService.createNote(title, description, date);
    if (response.statusCode == 201) {
      await fetchNotes();
    }
  }

  Future<void> updateNote(int id, String title, String description, String date) async {
    final response = await ApiService.updateNote(id, title, description, date);
    if (response.statusCode == 200) {
      await fetchNotes();
    }
  }

  Future<void> deleteNote(int id) async {
    final response = await ApiService.deleteNote(id);
    if (response.statusCode == 200) {
      _notes.removeWhere((note) => note.id == id);
      notifyListeners();
    }
  }
}
