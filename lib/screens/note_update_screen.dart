import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../models/note.dart';

class NoteUpdateScreen extends StatefulWidget {
  final Note note;
  NoteUpdateScreen({required this.note});

  @override
  State<NoteUpdateScreen> createState() => _NoteUpdateScreenState();
}

class _NoteUpdateScreenState extends State<NoteUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _descController = TextEditingController(text: widget.note.description);
    _dateController = TextEditingController(text: widget.note.date);
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Update Note")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Title"),
                validator: (val) => val!.isEmpty ? "Enter title" : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(labelText: "Description"),
                validator: (val) => val!.isEmpty ? "Enter description" : null,
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: "Date (YYYY-MM-DD)"),
                validator: (val) => val!.isEmpty ? "Enter date" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Update"),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await noteProvider.updateNote(
                      widget.note.id,
                      _titleController.text,
                      _descController.text,
                      _dateController.text,
                    );
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
