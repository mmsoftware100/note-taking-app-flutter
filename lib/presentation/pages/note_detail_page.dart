import 'package:flutter/material.dart';
import 'package:note/presentation/providers/note_provider.dart';
import 'package:provider/provider.dart';

class NoteDetailPage extends StatefulWidget {
  final String? noteId;

  const NoteDetailPage({super.key, this.noteId});

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool isNew = true;

  @override
  void initState() {
    super.initState();
    if (widget.noteId != null) {
      final note = Provider.of<NoteProvider>(context, listen : false).getNoteById(widget.noteId ?? "");
      if (note != null) {
        isNew = false;
        _titleController.text = note.title;
        _contentController.text = note.content;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<NoteProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? "New Note" : "Edit Note"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final title = _titleController.text.trim();
              final content = _contentController.text.trim();

              if (title.isEmpty && content.isEmpty) return;

              if (isNew) {
                provider.addNote(title, content);
              } else {
                provider.updateNote(widget.noteId!, title, content);
              }

              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: "Note...",
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
