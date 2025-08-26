import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';

class NoteAddScreen extends StatefulWidget {
  @override
  State<NoteAddScreen> createState() => _NoteAddScreenState();
}

class _NoteAddScreenState extends State<NoteAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Add Note")),
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
                child: Text("Save"),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await noteProvider.addNote(
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
