import 'package:flutter/material.dart';

class NoteNotifier extends ChangeNotifier {
  List<Note> currentNotes = [exampleNote, exampleNote];

  void addNote(Note note) {
    currentNotes.add(note);
    notifyListeners();
  }
}

class Note {
  final String title;
  final String body;
  final DateTime date;

  /// Ranges from 1 - 3. 1 is least important, 3 is very important
  final int priority;

  Note({this.title, this.body, this.date, this.priority});

  @override
  String toString() {
    return 'Note(title: $title, body: $body, date: $date, priority: $priority)';
  }
}

final exampleNote = Note(
  title: 'Creating a notes app',
  body: 'We need to be able to create, update, delete and read',
  date: DateTime(2020, 11, 7),
  priority: 1,
);
