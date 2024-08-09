import 'package:flutter/material.dart';
import '../models/note.dart';

class NotesViewModel extends ChangeNotifier {
  final List<Note> _notes = [
    Note(
      userId: '1',
      title: 'Project Update',
      content: 'Alice has provided an update on the project timeline.Alice has provided an update on the project timeline.Alice has provided an update on the project timeline.Alice has provided an update on the project timeline.Alice has provided an update on the project timeline.Alice has provided an update on the project timeline.Alice has provided an update on the project timeline.Alice has provided an update on the project timeline.',
      date: DateTime.now().subtract(Duration(days: 1)),
      appreciation: 'good',
    ),
    Note(
      userId: '1',
      title: 'Meeting Notes',
      content: 'Bob discussed the new features in the upcoming app update.',
      date: DateTime.now().subtract(Duration(days: 2)),
      appreciation: 'nul',
    ),
    Note(
      userId: '1',
      title: 'Design Review',
      content: 'Charlie has completed the initial design review.',
      date: DateTime.now().subtract(Duration(days: 3)),
      appreciation: 'bad',
    ),
    // Add more notes if needed
  ];


  List<Note> get notes => _notes;

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void removeNoteAt(int index) {
    _notes.removeAt(index);
    notifyListeners();
  }

  List<Note> getNotesForUser(String userId, {String? appreciation}) {
    return _notes.where((note) {
      bool matchesUser = note.userId == userId;
      bool matchesAppreciation = appreciation == null || note.appreciation == appreciation;
      return matchesUser && matchesAppreciation;
    }).toList();
  }

}
