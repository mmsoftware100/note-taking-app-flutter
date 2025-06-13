import 'package:flutter/material.dart';
import 'package:note/domain/entities/Note.dart';
import 'package:provider/provider.dart';

import '../providers/note_provider.dart';
import 'note_detail_page.dart';

class NoteHomePage extends StatefulWidget {
  const NoteHomePage({super.key});

  @override
  State<NoteHomePage> createState() => _NoteHomePageState();
}

class _NoteHomePageState extends State<NoteHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Keep Clone")),
      // body: _noteList(Provider.of<NoteProvider>(context, listen: true).noteList),
      body: Placeholder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NoteDetailPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _noteList(List<Note> notes){
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (_, index) {
        final note = notes[index];
        return ListTile(
          title: Text(note.title),
          subtitle: Text(
            note.content,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NoteDetailPage(noteId: note.id),
              ),
            );
          },
        );
      },
    );
  }
}
