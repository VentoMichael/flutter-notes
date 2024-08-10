import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/note.dart';
import '../../viewmodels/notes_viewmodel.dart';
import '../../constants.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  _CreateNotePageState createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final _userIdController = TextEditingController();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedAppreciation = 'good';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Note'),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _userIdController,
              decoration: const InputDecoration(labelText: 'User ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Note Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Note Content'),
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedAppreciation,
              decoration: const InputDecoration(labelText: 'Appreciation'),
              items: ['good', 'nul', 'bad']
                  .map((appreciation) => DropdownMenuItem<String>(
                value: appreciation,
                child: Text(appreciation.capitalize()),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedAppreciation = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newNote = Note(
                  userId: _userIdController.text,
                  title: _titleController.text,
                  content: _contentController.text,
                  date: DateTime.now(),
                  appreciation: _selectedAppreciation,
                );
                context.read<NotesViewModel>().addNote(newNote);

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text('Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}

extension StringCapitalize on String {
  String capitalize() {
    return this.isEmpty ? this : this[0].toUpperCase() + this.substring(1);
  }
}
