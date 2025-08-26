import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../providers/auth_provider.dart';
import 'note_add_screen.dart';
import 'note_update_screen.dart';
import '../models/note.dart';

class NoteListScreen extends StatefulWidget {
  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteProvider>(context, listen: false).fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Provider.of<NoteProvider>(context, listen: false).fetchNotes();
            },
          )
        ],
      ),
      body: noteProvider.notes.isEmpty
          ? Center(child: Text("No notes yet"))
          : ListView.builder(
        itemCount: noteProvider.notes.length,
        itemBuilder: (ctx, i) {
          Note note = noteProvider.notes[i];
          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => NoteUpdateScreen(note: note)),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    noteProvider.deleteNote(note.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NoteAddScreen()),
        ),
      ),
    );
  }
}
